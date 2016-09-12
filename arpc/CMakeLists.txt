set(TAME ${CMAKE_BINARY_DIR}/tame/tame)
#set(RPCC ${CMAKE_BINARY_DIR}/rpcc/rpcc)
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
#TODO do not commit with this TODO do not commit with this
# rpcc needs to build properly
set(RPCC /home/u0/ben/rpcc)

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/pmap_prot.h
    COMMAND ${RPCC}
    ARGS    -h ${CMAKE_CURRENT_SOURCE_DIR}/pmap_prot.x -o ${CMAKE_BINARY_DIR}/pmap_prot.h
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/pmap_prot.x)

# emulating the wonkiness in the old Makefile.am. This makes me fundamentally unhappy.
file(WRITE ${CMAKE_BINARY_DIR}/pmap_prot.c0 "#define proc XXX_egcs_bug_proc\n")
file(APPEND ${CMAKE_BINARY_DIR}/pmap_prot.c0 "#include \"sysconf.h\"\n")
file(APPEND ${CMAKE_BINARY_DIR}/pmap_prot.c0 "#undef proc\n")

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/pmap_prot.C~
    COMMAND cat ${CMAKE_BINARY_DIR}/pmap_prot.c0 > ${CMAKE_BINARY_DIR}/pmap_prot.C~
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/pmap_prot.x)

add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/pmap_prot.C
    COMMAND ${RPCC}
    ARGS    -c ${CMAKE_CURRENT_SOURCE_DIR}/pmap_prot.x -o - >> ${CMAKE_BINARY_DIR}/pmap_prot.C~ && mv -f ${CMAKE_BINARY_DIR}/pmap_prot.C~ ${CMAKE_BINARY_DIR}/pmap_prot.C
    DEPENDS ${CMAKE_BINARY_DIR}/pmap_prot.C~)

set(SOURCES
    authunixint.c
    ${CMAKE_BINARY_DIR}/pmap_prot.C
    ${CMAKE_BINARY_DIR}/pmap_prot.h
    extensible_arpc.C
    acallrpc.C
    aclnt.C
    asrv.C
    rpc_stats.C
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
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_BINARY_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_BINARY_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_SOURCE_DIR}/async/)

link_directories(
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_BINARY_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/libtame/)

ADD_LIBRARY(arpc SHARED ${SOURCES})
