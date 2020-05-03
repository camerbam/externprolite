# lcov_to_cobertura_xml
set(EXE_NAME lcov-to-cobertura-xml)
set(VER 1.6)
xpProOption(${EXE_NAME})
set(REPO https://github.com/eriwen/lcov-to-cobertura-xml)
set(PRO_LCOV-TO-COBERTURA-XML
  NAME ${EXE_NAME}
  WEB "${EXE_NAME}" "${REPO}" "${EXE_NAME} website"
  LICENSE "open" "${REPO}/blob/master/LICENSE" "${EXE_NAME} license: Apache"
  DESC "Converts lcov output to Cobertura-compatible XML for CI "
  REPO "repo" ${REPO} "${EXE_NAME} repo on github"
  VER ${VER}
  DLURL https://github.com/eriwen/${EXE_NAME}/archive/${VER}.tar.gz
  DLMD5 a72b0c318a0f08b704f487c6ef1e657d
  )
########################################
function(build_lcov_to_cobertura_xml)
  message(STATUS "build function")
  if(NOT (XP_DEFAULT OR XP_PRO_LCOV-TO-COBERTURA-XML))
    return()
  endif()
  xpGetArgValue(${PRO_LCOV-TO-COBERTURA-XML} ARG VER VALUE VER)
  configure_file(${PRO_DIR}/use/usexp-lcov-to-cobertura-xml-config.cmake ${STAGE_DIR}/share/cmake/
    @ONLY NEWLINE_STYLE LF
    )
    if(NOT TARGET lcov-to-cobertura-xml_copy)
    ExternalProject_Get_Property(lcov-to-cobertura-xml SOURCE_DIR)
    ExternalProject_Add(lcov-to-cobertura-xml_copy
      DEPENDS lcov-to-cobertura-xml
      DOWNLOAD_COMMAND "" DOWNLOAD_DIR ${NULL_DIR}
      CONFIGURE_COMMAND "" SOURCE_DIR ${NULL_DIR}
      BUILD_COMMAND ${CMAKE_COMMAND} -E copy ${SOURCE_DIR}/lcov_cobertura/lcov_cobertura.py "${STAGE_DIR}/share/lcov_cobertura.py"
      BINARY_DIR  ${NULL_DIR}
      INSTALL_COMMAND "" INSTALL_DIR  ${NULL_DIR}
      )
  endif()
endfunction()