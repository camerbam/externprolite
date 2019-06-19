# generate a Revision.hpp file
#  expected usage is to include this file so it runs at cmake-time
#  at cmake-time it creates a Revision_hpp target, which runs as a cmake script at build-time
# @param[in] xpSourceDir : source directory to run git commands from
# @param[in] xpRelBranch : name of release branch (revision shows differently if on release branch)
# http://stackoverflow.com/questions/3780667/use-cmake-to-get-build-time-svn-revision
if(NOT DEFINED xpSourceDir)
  message(FATAL_ERROR "xpSourceDir must be set before including revision.cmake")
endif()
if(NOT DEFINED xpRelBranch)
  message(FATAL_ERROR "xpRelBranch must be set before including revision.cmake")
endif()
include(FindGit)
if(NOT GIT_FOUND AND NOT UNIX)
  find_program(GIT_EXECUTABLE
    NAMES git.exe HINTS $ENV{SystemDrive}/cygwin/bin
    DOC "git command line client (cygwin)"
    )
  if(GIT_EXECUTABLE)
    find_package(Git)
  endif()
endif()
if(GIT_FOUND AND EXISTS "${xpSourceDir}/.git")
  # xpRelBranch (release branch): date yyyymmdd-gitdescribe (20120518-gitdescribe)
  # other branches: user-branch-gitdescribe (cfrandsen-padawan-gitdescribe)
  execute_process(COMMAND ${GIT_EXECUTABLE} name-rev --name-only HEAD
    WORKING_DIRECTORY ${xpSourceDir}
    OUTPUT_VARIABLE refsBranchName
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  string(REPLACE "remotes/origin/" "" branchName ${refsBranchName}) # submodules need this
  if(${branchName} STREQUAL ${xpRelBranch})
    string(TIMESTAMP ymd %Y%m%d)
    set(revisionPrefix "${ymd}")
  elseif(UNIX)
    set(revisionPrefix "$ENV{USER}-${branchName}")
  else()
    set(revisionPrefix "$ENV{USERNAME}-${branchName}")
  endif()
  # 'git describe' favors annotated tags (created with the -a or -s flag)
  # execute 'git describe --tags' command to find lightweight tag
  execute_process(COMMAND ${GIT_EXECUTABLE} describe --tags
    WORKING_DIRECTORY ${xpSourceDir}
    OUTPUT_VARIABLE gitDescribe
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_VARIABLE gitErr
    )
  if(gitErr) # no tags found...
    set(gitDescribe "notag")
  endif()
  set(xpRevision "${revisionPrefix}-${gitDescribe}")
else()
  set(xpRevision "Unknown-revision")
  message(AUTHOR_WARNING "Not a git repository? Using revision: ${xpRevision}.")
endif()
# write a txt file with only the revision, so other cmake can get it:
#  file(READ ${CMAKE_BINARY_DIR}/revision.txt revNum)
#  string(STRIP ${revNum} revNum)
file(WRITE ${CMAKE_BINARY_DIR}/revision.txt
  "${xpRevision}\n"
  )
# write a file with the SCM_REV_NUM define
file(WRITE ${CMAKE_BINARY_DIR}/revision.h.txt
  "#define SCM_REV_NUM \"${xpRevision}\"\n"
  )
# copy the file to the final header only if the revision changes
# reduces needless rebuilds
execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different
  ${CMAKE_BINARY_DIR}/revision.h.txt ${CMAKE_BINARY_DIR}/Revision.hpp
  )
################################################################################
# do the following at cmake-time so the Revision_hpp target exists at build-time
if(NOT TARGET Revision_hpp AND DEFINED CMAKE_SYSTEM_NAME)
  add_custom_command(OUTPUT revision_cmake
    COMMAND ${CMAKE_COMMAND}
      -DxpSourceDir:FILEPATH="${xpSourceDir}"
      -DxpRelBranch:STRING="${xpRelBranch}"
      -P ${CMAKE_CURRENT_LIST_FILE}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Generating Revision.hpp..."
    )
  add_custom_target(Revision_hpp
    SOURCES ${CMAKE_CURRENT_LIST_FILE}
    DEPENDS revision_cmake
    )
  set_property(TARGET Revision_hpp PROPERTY FOLDER CMakeTargets)
endif()
