# CMakeLists.txt
# Build libaapp

set(TAME ${CMAKE_BINARY_DIR}/tame/tame)
#TODO DO NOT COMMIT
set(RPCC /home/u0/ben/rpcc)

set(LIBAAPP_SRC
    accept.C)

set(LIBAAPP_T_SOURCES logger.T)
set(CXXFILES)
foreach( t_file ${LIBAAPP_T_SOURCES} )
    get_filename_component(name_file ${t_file} NAME)
    string( REPLACE ".T" ".cxx" cxx_file_path ${t_file} )
    get_filename_component(cxx_file ${cxx_file_path} NAME)
    string( REPLACE ".T" "" f_name ${name_file} )
    add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/libaapp/${cxx_file}
        COMMAND ${TAME}
        ARGS    ${PROJECT_SOURCE_DIR}/libaapp/${t_file} > ${CMAKE_BINARY_DIR}/libaapp/${cxx_file}
        DEPENDS ${PROJECT_SOURCE_DIR}/libaapp/${t_file})
    list(APPEND CXXFILES ${CMAKE_BINARY_DIR}/libaapp/${cxx_file})
endforeach( t_file ${LIBAAPP_T_SOURCES} )

set(HFILES)
set(CFILES)
set(PROT_HEADERS aapp_prot.x)
foreach(x_file ${PROT_HEADERS})
    string(REPLACE ".x" ".h" h_file ${x_file})
    string(REPLACE ".x" ".C" c_file ${x_file})
    add_custom_command(
        OUTPUT ${c_file}
        COMMAND ${RPCC}
        ARGS    -c ${CMAKE_SOURCE_DIR}/libaapp/${x_file}
        DEPENDS ${x_file})
    list(APPEND CFILES ${c_file})
    add_custom_command(
        OUTPUT ${h_file}
        COMMAND ${RPCC}
        ARGS    -h ${CMAKE_SOURCE_DIR}/libaapp/${x_file}
        DEPENDS ${x_file})
    list(APPEND HFILES ${h_file})
endforeach(x_file ${PROT_HEADERS})


include_directories(
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_BINARY_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/libtame/
    ${CMAKE_BINARY_DIR}/libaapp/
    ${CMAKE_SOURCE_DIR}/libaapp/
    ${CMAKE_SOURCE_DIR}/async/)

link_directories(
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_BINARY_DIR}/libaapp/
    ${CMAKE_SOURCE_DIR}/libaapp/)

ADD_LIBRARY(libaapp SHARED ${CFILES} ${HFILES} ${LIBAAPP_SRC} ${CXXFILES})

#set(LIBAAPP_HEADERS
#     tame_event.h
#     tame_run.h
#     tame_recycle.h
#     tame_weakref.h
#     tame_closure.h
#     tame_rendezvous.h
#     tame_event_ag.h
#     tame_tfork.h
#     tame_tfork_ag.h
#     tame_thread.h
#     tame_typedefs.h
#     tame_slotset.h
#     tame.h
#     tame_pipeline.h
#     tame_lock.h
#     tame_autocb.h
#     tame_trigger.h
#     tame_pc.h
#     tame_io.h
#     tame_aio.h
#     tame_rpcserver.h
#     tame_rpc.h
#     tame_profiler.h
#     tame_pipeline3.h)
#
#set(LIBAAPP_C_SRC
#    closure.C
#    event.C
#    init.C
#    leak.C
#    mkevent.C
#    profiler.C
#    recycle.C
#    run.C
#    tfork.C
#    thread.C
#    trigger.C)
#
#set(LIBAAPP_T_SOURCES
#    aio.T
#    connectors.T
#    io.T
#    lock.T
#    pipeline3.T
#    pipeline.T
#    rpcserver.T)
#
## Deal with combo .T files
#set(CXXFILES)
#foreach( t_file ${LIBAAPP_T_SOURCES} )
#    get_filename_component(name_file ${t_file} NAME)
#    string( REPLACE ".T" ".cxx" cxx_file_path ${t_file} )
#    get_filename_component(cxx_file ${cxx_file_path} NAME)
#    string( REPLACE ".T" "" f_name ${name_file} )
#    add_custom_command(
#        OUTPUT ${CMAKE_BINARY_DIR}/libaapp/${cxx_file}
#        COMMAND ${TAME}
#        ARGS    ${PROJECT_SOURCE_DIR}/libaapp/${t_file} > ${CMAKE_BINARY_DIR}/libaapp/${cxx_file}
#        DEPENDS ${PROJECT_SOURCE_DIR}/libaapp/${t_file})
#    list(APPEND CXXFILES ${CMAKE_BINARY_DIR}/libaapp/${cxx_file})
#endforeach( t_file ${LIBAAPP_T_SOURCES} )
#
#    get_filename_component(name_file ${th_file} NAME)
#    string( REPLACE ".Th" ".h" h_file_path ${th_file} )
#    get_filename_component(h_file ${h_file_path} NAME)
#    string( REPLACE ".T" "" f_name ${name_file} )
#    add_custom_command(
#        OUTPUT ${h_file}
#        COMMAND ${TAME}
#        ARGS    -o ${h_file} ${PROJECT_SOURCE_DIR}/libaapp/${th_file}
#        DEPENDS ${PROJECT_SOURCE_DIR}/libaapp/${th_file})
#    list(APPEND HFILES ${h_file})
#endforeach( th_file ${HEADERS} )
#
