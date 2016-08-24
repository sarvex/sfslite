# CMakeLists.txt
# Build libtame

set(TAME ${CMAKE_BINARY_DIR}/tame/tame)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=gnu++14") # prefer c++, but this needs gnu specific violations

# PERLED FILES
add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/libtame/tame_event_ag.h
    COMMAND perl ${CMAKE_SOURCE_DIR}/libtame/mkevent.pl > ${CMAKE_BINARY_DIR}/libtame/tame_event_ag.h
    DEPENDS mkevent.pl)
add_custom_command(
    OUTPUT ${CMAKE_BINARY_DIR}/libtame/tame_tfork_ag.h
    COMMAND perl ${CMAKE_SOURCE_DIR}/libtame/mktfork_ag.pl > ${CMAKE_BINARY_DIR}/libtame/tame_tfork_ag.h
    DEPENDS mktfork_ag.pl)

set(PERLED_FILES
    ${CMAKE_BINARY_DIR}/libtame/tame_tfork_ag.h
    ${CMAKE_BINARY_DIR}/libtame/tame_event_ag.h)

# Deal with combo .T files
set(CXXFILES)
#set(SOURCES ${LIBTAME_SRC})
file(GLOB_RECURSE SOURCES ${PROJECT_SOURCE_DIR}/libtame/*.T)
foreach( t_file ${SOURCES} )
    get_filename_component(name_file ${t_file} NAME)
    string( REPLACE ".T" ".cxx" cxx_file_path ${t_file} )
    get_filename_component(cxx_file ${cxx_file_path} NAME)
    string( REPLACE ".T" "" f_name ${name_file} )
    add_custom_command(
        OUTPUT ${CMAKE_BINARY_DIR}/libtame/${cxx_file}
        COMMAND ${TAME}
        ARGS    ${t_file} > ${CMAKE_BINARY_DIR}/libtame/${cxx_file}
        DEPENDS ${t_file})
    #MESSAGE(${cxx_file})
    list(APPEND CXXFILES ${CMAKE_BINARY_DIR}/libtame/${cxx_file})
endforeach( t_file ${SOURCES} )


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

set(LIBTAME_HEADERS
     tame_event.h
     tame_run.h
     tame_recycle.h
     tame_weakref.h
     tame_closure.h
     tame_rendezvous.h
     tame_event_ag.h
     tame_tfork.h
     tame_tfork_ag.h
     tame_thread.h
     tame_typedefs.h
     tame_slotset.h
     tame.h
     tame_pipeline.h
     tame_lock.h
     tame_autocb.h
     tame_trigger.h
     tame_pc.h
     tame_io.h
     tame_aio.h
     tame_rpcserver.h
     tame_rpc.h
     tame_profiler.h
     tame_pipeline3.h)

#set(LIBTAME_SRC
#    ${PROJECT_SOURCE_DIR}/libtame/pipeline.T
#    ${PROJECT_SOURCE_DIR}/libtame/lock.T)

# Deal with combo .Th files
set(HFILES)
file(GLOB_RECURSE HEADERS ${PROJECT_SOURCE_DIR}/libtame/*.Th)
foreach( th_file ${HEADERS} )
    get_filename_component(name_file ${th_file} NAME)
    string( REPLACE ".Th" ".h" h_file_path ${th_file} )
    get_filename_component(h_file ${h_file_path} NAME)
    string( REPLACE ".T" "" f_name ${name_file} )
    add_custom_command(
        OUTPUT ${h_file}
        COMMAND ${TAME}
        ARGS    -o ${h_file} ${th_file}
        DEPENDS ${th_file})
    list(APPEND HFILES ${h_file})
endforeach( th_file ${HEADERS} )

SET(LIBTAME_SOURCE_FILES ${LIBTAME_HEADERS} ${CXXFILES} ${HFILES})
ADD_LIBRARY(libtame SHARED ${PERLED_FILES} ${LIBTAME_SOURCE_FILES})
