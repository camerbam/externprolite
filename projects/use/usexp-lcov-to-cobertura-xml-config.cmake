set(prj lcov-to-cobertura-xml)
# this file (-config) installed to share
get_filename_component(WP_ROOTDIR ${CMAKE_CURRENT_LIST_DIR}/../.. ABSOLUTE)
get_filename_component(WP_ROOTDIR ${WP_ROOTDIR} ABSOLUTE) # remove relative parts
string(TOUPPER ${prj} PRJ)
set(${PRJ}_VER "@VER@ [@PROJECT_NAME@]")
set(${PRJ}_SCRIPT ${WP_ROOTDIR}/share/lcov_cobertura.py)
set(reqVars ${PRJ}_VER ${PRJ}_SCRIPT)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(${prj} REQUIRED_VARS ${reqVars})
mark_as_advanced(${reqVars})
