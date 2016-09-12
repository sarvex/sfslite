# CMakeLists.txt
# Build libsfs


set(SOURCES gc.C freemap.C gc_str.C)

#add_definitions(-DHAVE_CONFIG_H)
#add_definitions(-DEXECDIR=\"/usr/local/lib/sfslite-1.2\")
#add_definitions(-DETCDIR=\"/etc/sfs\")
#add_definitions(-DDATADIR=\"/usr/local/share/sfslite\")
#add_definitions(-DPIDDIR=\"/usr/local/share/sfslite\")
#add_definitions(-DSFSDIR=\"/var/sfs\")
#
#set(ARPCGEN ${CMAKE_BINARY_DIR}/arpcgen/arpcgen)
#set(SVC_SRC_DIR ${CMAKE_SOURCE_DIR}/svc)
#
include_directories(
    ${CMAKE_BINARY_DIR}/libtame/
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/
#    ${CMAKE_BINARY_DIR}/libsfs/
#    ${CMAKE_SOURCE_DIR}/libsfs/
#    ${CMAKE_SOURCE_DIR}/arpc/
#    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_SOURCE_DIR}/async/)
#
#link_directories(
#    ${CMAKE_BINARY_DIR}/
#    ${CMAKE_SOURCE_DIR}/
#    ${CMAKE_BINARY_DIR}/libsfs/
#    ${CMAKE_SOURCE_DIR}/libsfs/
#    ${CMAKE_BINARY_DIR}/arpc/
#    ${CMAKE_SOURCE_DIR}/arpc/
#    ${CMAKE_SOURCE_DIR}/libtame/)
#
## generate .c & .h files from svc proto files
#set(PROTOSOURCES
#    ${SVC_SRC_DIR}/nfs3_prot.x
#    ${SVC_SRC_DIR}/nfs3exp_prot.x
#    ${SVC_SRC_DIR}/sfs_prot.x
#    ${SVC_SRC_DIR}/sfsagent.x)
#
#set(GEN_C_FILES)
#set(GEN_H_FILES)
#foreach(x_file ${PROTOSOURCES})
#    get_filename_component(file_path ${x_file} NAME)
#    string(REPLACE ".x" ".h" h_file ${file_path})
#    #MESSAGE(${ARPCGEN} -r sfs-internal.h -h ${x_file} -o ${CMAKE_BINARY_DIR}/libsfs/${h_file})
#    add_custom_command(
#        OUTPUT ${CMAKE_BINARY_DIR}/libsfs/${h_file}
#        COMMAND ${ARPCGEN}
#        ARGS    -r ${CMAKE_SOURCE_DIR}/libsfs/sfs-internal.h -h ${x_file} -o ${CMAKE_BINARY_DIR}/libsfs/${h_file}
#        DEPENDS ${x_file})
#    list(APPEND GEN_H_FILES ${CMAKE_BINARY_DIR}/libsfs/${h_file})
#
#    string(REPLACE ".x" ".c" c_file ${file_path})
#    add_custom_command(
#        OUTPUT ${CMAKE_BINARY_DIR}/libsfs/${c_file}
#        COMMAND ${ARPCGEN}
#        ARGS    -c ${x_file} -o ${CMAKE_BINARY_DIR}/libsfs/${c_file}
#        DEPENDS ${x_file})
#    list(APPEND GEN_C_FILES ${CMAKE_BINARY_DIR}/libsfs/${c_file})
#endforeach(x_file ${PROTOSOURCES})
#
## Generate the libsfs library
#set(LIBSFS_SOURCE
#    devcon.c hashtab.c sfsops.c sfspaths.c srpc.c xdr_misc.c suio.c)
#
#set(OTHER_SOURCES # WHY
#    ${CMAKE_SOURCE_DIR}/async/rwfd.c
#    ${CMAKE_SOURCE_DIR}/async/suidprotect.c
#    ${CMAKE_SOURCE_DIR}/arpc/authunixint.c)
#
ADD_LIBRARY(libsafeptr SHARED ${SOURCES})
#
## Generate the libsfs executables
#
#add_executable(suidconnect suidconnect.c)
#target_link_libraries(suidconnect PUBLIC libsfs)
#
#add_executable(pathinfo pathinfo.c)
#target_link_libraries(pathinfo PUBLIC libsfs)
#
## TODO figure out if we need auth helper exec
