include_directories(
    ${CMAKE_BINARY_DIR}/ # in the build directory
    ${CMAKE_SOURCE_DIR}/arpcgen/
    ${CMAKE_SOURCE_DIR}/async/)

link_directories( ${CMAKE_BINARY_DIR}) # in the build director

set(SOURCES
    rpc_cout.c rpc_hout.c rpc_main.c rpc_parse.c rpc_scan.c rpc_tblout.c rpc_util.c)

add_executable(arpcgen ${SOURCES})
