set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=gnu++14 -Wno-error")
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

MESSAGE(${RPCC})






include_directories(
    ${CMAKE_BINARY_DIR}/libsfs/
    ${CMAKE_SOURCE_DIR}/libsfs/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/async/
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/)

link_directories(
    ${CMAKE_BINARY_DIR}/libsfs/
    ${CMAKE_SOURCE_DIR}/libsfs/
    ${CMAKE_BINARY_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_BINARY_DIR}/rpcc/
    ${CMAKE_SOURCE_DIR}/rpcc/
    ${CMAKE_BINARY_DIR}/async/)

#    sfsagent.x sfscd_prot.x nfsmounter.x rex_prot.x auth_helper_prot.x test_arpc_prot.x nfs3_ext.x  )

#set(HFILES)
#foreach( prot_file ${PROT_HEADERS} )
#    string( REPLACE ".x" ".h" HFILE ${prot_file} )
#    add_custom_command(
#        OUTPUT ${CMAKE_BINARY_DIR}/svc/${HFILE}
#        COMMAND ${RPCC}
#        ARGS    -h -DSFSSVC ${CMAKE_SOURCE_DIR}/svc/${prot_file} -o ${CMAKE_BINARY_DIR}/svc/${HFILE}
#        DEPENDS ${CMAKE_SOURCE_DIR}/svc/${prot_file})
#    list(APPEND HFILES ${CMAKE_BINARY_DIR}/svc/${HFILE})
#endforeach( prot_file ${PROT_HEADRERS} )

#set(CFILES)
#foreach( prot_file ${PROT_HEADERS} )
#    string( REPLACE ".x" ".c" CFILE ${prot_file} )
#    add_custom_command(
#        OUTPUT ${CMAKE_BINARY_DIR}/svc/${CFILE}
#        COMMAND ${RPCC}
#        ARGS    -c -DSFSSVC ${CMAKE_SOURCE_DIR}/svc/${prot_file} -o ${CMAKE_BINARY_DIR}/svc/${CFILE}
#        DEPENDS ${CMAKE_SOURCE_DIR}/svc/${prot_file})
#    list(APPEND CFILES ${CMAKE_BINARY_DIR}/svc/${CFILE})
#endforeach( prot_file ${PROT_HEADERS} )

set(HFILES)
set(CFILES)
set(PROT_HEADERS nfs_prot.x)
foreach( x_file ${PROT_HEADERS} )
    #get_filename_component(name_file ${th_file} NAME)
    string( REPLACE ".x" ".h" h_file ${x_file} )
    string( REPLACE ".x" ".C" c_file ${x_file} )
    #get_filename_component(h_file ${h_file_path} NAME)
    add_custom_command(
        OUTPUT ${c_file}
        COMMAND ${RPCC}
        ARGS    -c -DSFSSVC ${CMAKE_SOURCE_DIR}/svc/${x_file}
        DEPENDS ${x_file})
    list(APPEND CFILES ${c_file})
    add_custom_command(
        OUTPUT ${h_file}
        COMMAND ${RPCC}
        ARGS    -h -DSFSSVC ${CMAKE_SOURCE_DIR}/svc/${x_file}
        DEPENDS ${x_file})
    list(APPEND HFILES ${h_file})
endforeach( x_file ${PROT_HEADERS} )

#MESSAGE(${HFILES})
#MESSAGE(${CFILES})


#nfs_prot.h nfs3_prot.h nfs3exp_prot.h nfs3close_prot.h mount_prot.h sfs_prot.h sfsauth_prot.h sfsagent.h sfscd_prot.h nfsmounter.h rex_prot.h auth_helper_prot.h test_arpc_prot.h $(UVFS_HFILES)

#link_directories( ${CMAKE_BINARY_DIR}) # in the build director

#set(SOURCES
#    rpc_cout.c rpc_hout.c rpc_main.c rpc_parse.c rpc_scan.c rpc_tblout.c rpc_util.c)

#SET(LIBTAME_SOURCE_FILES ${LIBTAME_HEADERS} ${CXXFILES} ${HFILES})
ADD_LIBRARY(svc SHARED ${CFILES} ${HFILES})
