
set(SOURCES
    authunixint.c
    #    pmap_prot.C
    acallrpc.C
    aclnt.C
    asrv.C
    authopaque.C
    authuint.C
    axprt_dgram.C
    axprt_pipe.C
    axprt_stream.C
    axprt_unix.C
    clone.C
    xdr_suio.C
    xdrmisc.C
    xhinfo.C)

include_directories(
    ${CMAKE_BINARY_DIR}/libtame/ # in the build directory
    ${CMAKE_BINARY_DIR}/ # in the build directory
    ${CMAKE_SOURCE_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/         # in the source tree
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_SOURCE_DIR}/async/)

link_directories(
    ${CMAKE_BINARY_DIR}/ # in the build directory
    ${CMAKE_BINARY_DIR}/libtame/ # in the build directory
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_SOURCE_DIR}/libtame/)

ADD_LIBRARY(arpc SHARED ${SOURCES})
