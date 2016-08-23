# CMakeLists.txt
# Build tools

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")





set(TAME_SOURCE parse.h tame.C const.C output.C  parse.cc  processor.C scan.cc tame.h)
add_executable(tame ${TAME_SOURCE})
target_link_libraries(tame PUBLIC async pcre resolv nsl gmp)









#
## PERLED FILES
#add_custom_command(
#    OUTPUT tame_event_ag.h
#    COMMAND perl ${CMAKE_SOURCE_DIR}/libtame/mkevent.pl > tame_event_ag.h
#    DEPENDS mkevent.pl)
#add_custom_command(
#    OUTPUT tame_tfork_ag.h
#    COMMAND perl ${CMAKE_SOURCE_DIR}/libtame/mktfork_ag.pl > tame_tfork_ag.h
#    DEPENDS mktfork_ag.pl)
#
#set(PERLED_FILES tame_event_ag.h
#                 tame_tfork_ag.h)
#
## Include and links
include_directories(
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/async/)

#    ${CMAKE_SOURCE_DIR}/tame/
#    ${CMAKE_SOURCE_DIR}/arpc/
#    ${CMAKE_SOURCE_DIR}/rpc/
#    ${CMAKE_SOURCE_DIR}/crypt/
#
link_directories(
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/tame/
    ${CMAKE_BINARY_DIR}/tame/)
#    ${CMAKE_SOURCE_DIR}/arpc/
#    ${CMAKE_SOURCE_DIR}/crypt/
#    ${CMAKE_SOURCE_DIR}/async/)
#
## Deal with combo .Th files
#set(HFILES)
#file(GLOB_RECURSE HEADERS ${PROJECT_SOURCE_DIR}/libtame/*.Th)
#foreach( th_file ${HEADERS} )
#    get_filename_component(name_file ${th_file} NAME)
#    string( REPLACE ".Th" ".h" h_file_path ${th_file} )
#    get_filename_component(h_file ${h_file_path} NAME)
#    string( REPLACE ".T" "" f_name ${name_file} )
#    add_custom_command(
#        OUTPUT ${h_file}
#        COMMAND ${TAME}
#        ARGS    -o ${h_file} ${th_file}
#        DEPENDS ${th_file})
#    list(APPEND HFILES ${h_file})
#endforeach( th_file ${HEADERS} )
#
## Deal with combo .T files
#set(CXXFILES)
#file(GLOB_RECURSE SOURCES ${PROJECT_SOURCE_DIR}/libtame/*.T)
#foreach( t_file ${SOURCES} )
#    get_filename_component(name_file ${t_file} NAME)
#    string( REPLACE ".T" ".cxx" cxx_file_path ${t_file} )
#    get_filename_component(cxx_file ${cxx_file_path} NAME)
#    string( REPLACE ".T" "" f_name ${name_file} )
#    add_custom_command(
#        OUTPUT ${cxx_file}
#        COMMAND ${TAME}
#        ARGS    ${t_file} > ${cxx_file}
#        DEPENDS ${t_file})
#    list(APPEND CXXFILES ${cxx_file})
#endforeach( t_file ${SOURCES} )
#
#SET(LIBTAME_SOURCE_FILES ${CXXFILES} ${HFILES})
#ADD_LIBRARY(tame SHARED ${LIBTAME_SOURCE_FILES} ${PERLED_FILES})

#find_package(BISON 2.1.3)
#set(TAME_SOURCE tame.C processor.C const.C output.C )
#file(GLOB_RECURSE TAME_HEADERS ${PROJECT_SOURCE_DIR}/tame/*.h)
#set(BISON_SOURCE ${PROJECT_SOURCE_DIR}/tame/parse.yy)
#BISON_TARGET(MyParser ${BISON_SOURCE} ${PROJECT_SOURCE_DIR}/parse.cc
#    DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parser.h)
#add_executable(tame ${TAME_HEADERS} ${BISON_MyParser_OUTPUTS} ${BISON_MyParser_OUTPUT_HEADER} ${TAME_SOURCE})
