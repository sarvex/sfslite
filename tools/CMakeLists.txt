## CMakeLists.txt
# Build the tools

# Deal with combo .T files
set(RTFTPC_CXX)
set(RTFTPC_T_SOURCES ${PROJECT_SOURCE_DIR}/tools/rtftp/cli.T)
foreach( t_file ${RTFTPC_T_SOURCES} )
    get_filename_component(name_file ${t_file} NAME)
    string( REPLACE ".T" ".C" cxx_file_path ${t_file} )
    get_filename_component(cxx_file ${cxx_file_path} NAME)
    string( REPLACE ".T" "" f_name ${name_file} )
    add_custom_command(
        OUTPUT ${PROJECT_BINARY_DIR}/tools/${cxx_file}
        COMMAND ${TAME}
        ARGS    ${t_file} > ${PROJECT_BINARY_DIR}/tools/${cxx_file}
        DEPENDS ${t_file})
    list(APPEND RTFTPC_CXX ${PROJECT_BINARY_DIR}/tools/${cxx_file})
endforeach( t_file ${RTFTPC_T_SOURCES} )

set(RTFTPD_CXX)
set(RTFTPD_T_SOURCES ${PROJECT_SOURCE_DIR}/tools/rtftp/srv.T)
foreach( t_file ${RTFTPD_T_SOURCES} )
    get_filename_component(name_file ${t_file} NAME)
    string( REPLACE ".T" ".C" cxx_file_path ${t_file} )
    get_filename_component(cxx_file ${cxx_file_path} NAME)
    string( REPLACE ".T" "" f_name ${name_file} )
    add_custom_command(
        OUTPUT ${PROJECT_BINARY_DIR}/tools/${cxx_file}
        COMMAND ${TAME}
        ARGS    ${t_file} > ${PROJECT_BINARY_DIR}/tools/${cxx_file}
        DEPENDS ${t_file})
    list(APPEND RTFTPD_CXX ${PROJECT_BINARY_DIR}/tools/${cxx_file})
endforeach( t_file ${RTFTPD_T_SOURCES} )

set(NCPP_CXX)
set(NCPP_T_SOURCES ${PROJECT_SOURCE_DIR}/tools/ncpp/ncpp.T)
foreach(t_file ${NCPP_T_SOURCES})
    get_filename_component(name_file ${t_file} NAME)
    string( REPLACE ".T" ".C" cxx_file_path ${t_file} )
    get_filename_component(cxx_file ${cxx_file_path} NAME)
    string( REPLACE ".T" "" f_name ${name_file} )
    add_custom_command(
        OUTPUT ${PROJECT_BINARY_DIR}/tools/${cxx_file}
        COMMAND ${TAME}
        ARGS    ${t_file} > ${PROJECT_BINARY_DIR}/tools/${cxx_file}
        DEPENDS ${t_file})
    list(APPEND NCPP_CXX ${PROJECT_BINARY_DIR}/tools/${cxx_file})
endforeach(t_file ${NCPP_T_SOURCES})

set(TINETD_CXX)
set(TINETD_T_SOURCES ${PROJECT_SOURCE_DIR}/tools/tinetd/tinetd.T)
foreach(t_file ${NCPP_T_SOURCES})
    get_filename_component(name_file ${t_file} NAME)
    string( REPLACE ".T" ".C" cxx_file_path ${t_file} )
    get_filename_component(cxx_file ${cxx_file_path} NAME)
    string( REPLACE ".T" "" f_name ${name_file} )
    add_custom_command(
        OUTPUT ${PROJECT_BINARY_DIR}/tools/${cxx_file}
        COMMAND ${TAME}
        ARGS    ${t_file} > ${PROJECT_BINARY_DIR}/tools/${cxx_file}
        DEPENDS ${t_file})
    list(APPEND TINETD_CXX ${PROJECT_BINARY_DIR}/tools/${cxx_file})
endforeach(t_file ${NCPP_T_SOURCES})

add_custom_command(
    OUTPUT ${PROJECT_BINARY_DIR}/tools/rtftp_prot.C
    COMMAND ${RPCC}
    ARGS    -c ${PROJECT_SOURCE_DIR}/tools/rtftp/rtftp_prot.x -o ${PROJECT_BINARY_DIR}/tools/rtftp_prot.C
    DEPENDS ${PROJECT_SOURCE_DIR}/tools/rtftp/rtftp_prot.x)

add_custom_command(
    OUTPUT ${PROJECT_BINARY_DIR}/tools/rtftp_prot.h
    COMMAND ${RPCC}
    ARGS    -h ${PROJECT_SOURCE_DIR}/tools/rtftp/rtftp_prot.x -o ${PROJECT_BINARY_DIR}/tools/rtftp_prot.h
    DEPENDS ${PROJECT_SOURCE_DIR}/tools/rtftp/rtftp_prot.x)

set(RTFTPC_SOURCES
    ${PROJECT_BINARY_DIR}/tools/rtftp_prot.h
    ${PROJECT_SOURCE_DIR}/tools/rtftp/rtftp.h
    ${PROJECT_SOURCE_DIR}/tools/rtftp/util.C)

set(RTFTPD_SOURCES
    ${PROJECT_BINARY_DIR}/tools/rtftp_prot.h
    ${PROJECT_SOURCE_DIR}/tools/rtftp/util.C)

# Include and links
include_directories(
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/libtame/
    ${CMAKE_BINARY_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/libaapp/
    ${CMAKE_BINARY_DIR}/libaapp/
    ${CMAKE_SOURCE_DIR}/tools/rtftp/
    ${CMAKE_BINARY_DIR}/tools/rtftp/
    ${CMAKE_BINARY_DIR}/tools/
    ${CMAKE_BINARY_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_BINARY_DIR}/crypt/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/async/)

link_directories(
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/libtame/
    ${CMAKE_BINARY_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/tame/
    ${CMAKE_BINARY_DIR}/tame/
    ${CMAKE_SOURCE_DIR}/tools/rtftp/
    ${CMAKE_BINARY_DIR}/tools/rtftp/
    ${CMAKE_BINARY_DIR}/tools/
    ${CMAKE_SOURCE_DIR}/tools/
    ${CMAKE_BINARY_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_BINARY_DIR}/crypt/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/async/)

#add_executable(rtftpc ${RTFTPC_CXX} ${RTFTPC_SOURCES})
#target_link_libraries(rtftpc PUBLIC crypt libtame arpc async pcre resolv nsl gmp crypt)
#
#add_executable(rtftpd ${RTFTPD_CXX} ${RTFTPD_SOURCES})
#target_link_libraries(rtftpd PUBLIC crypt libtame arpc async pcre resolv nsl gmp crypt)

add_executable(ncpp ${NCPP_CXX})
target_link_libraries(ncpp PUBLIC crypt libtame arpc async pcre resolv nsl gmp crypt)

add_executable(tinetd ${TINETD_CXX})
target_link_libraries(tinetd PUBLIC crypt libtame arpc async pcre resolv nsl gmp crypt)

add_executable(logger ${PROJECT_SOURCE_DIR}/tools/logger/logger.C)
target_link_libraries(logger PUBLIC crypt libaapp libtame arpc async pcre resolv nsl gmp crypt)
