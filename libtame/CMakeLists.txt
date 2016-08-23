# CMakeLists.txt
# Build libtame

set(TAME ${CMAKE_BINARY_DIR}/tame/tame)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")

# PERLED FILES
add_custom_command(
    OUTPUT tame_event_ag.h
    COMMAND perl ${CMAKE_SOURCE_DIR}/libtame/mkevent.pl > tame_event_ag.h
    DEPENDS mkevent.pl)
add_custom_command(
    OUTPUT tame_tfork_ag.h
    COMMAND perl ${CMAKE_SOURCE_DIR}/libtame/mktfork_ag.pl > tame_tfork_ag.h
    DEPENDS mktfork_ag.pl)

set(PERLED_FILES tame_event_ag.h
                 tame_tfork_ag.h)

# Include and links
include_directories(
    ${CMAKE_BINARY_DIR}/libtame/ # in the build directory

    ${CMAKE_SOURCE_DIR}/         # in the source tree
    ${CMAKE_SOURCE_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_SOURCE_DIR}/async/)

link_directories(
    ${CMAKE_BINARY_DIR}/ # in the build directory
    ${CMAKE_BINARY_DIR}/libtame/ # in the build directory
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_SOURCE_DIR}/libtame/)

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

# Deal with combo .T files
set(CXXFILES)
file(GLOB_RECURSE SOURCES ${PROJECT_SOURCE_DIR}/libtame/*.T)
foreach( t_file ${SOURCES} )
    get_filename_component(name_file ${t_file} NAME)
    string( REPLACE ".T" ".cxx" cxx_file_path ${t_file} )
    get_filename_component(cxx_file ${cxx_file_path} NAME)
    string( REPLACE ".T" "" f_name ${name_file} )
    add_custom_command(
        OUTPUT ${cxx_file}
        COMMAND ${TAME}
        ARGS    ${t_file} > ${cxx_file}
        DEPENDS ${t_file})
    list(APPEND CXXFILES ${cxx_file})
endforeach( t_file ${SOURCES} )

SET(LIBTAME_SOURCE_FILES ${CXXFILES} ${HFILES})
ADD_LIBRARY(libtame SHARED ${LIBTAME_SOURCE_FILES} ${PERLED_FILES})
