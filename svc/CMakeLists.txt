#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=gnu++14 -Wno-error")
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

include_directories(
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_SOURCE_DIR}/async/
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_BINARY_DIR}/)

link_directories(
    ${CMAKE_BINARY_DIR}/libsfs/
    ${CMAKE_SOURCE_DIR}/libsfs/
    ${CMAKE_BINARY_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_BINARY_DIR}/rpcc/
    ${CMAKE_SOURCE_DIR}/rpcc/
    ${CMAKE_BINARY_DIR}/async/)

set(HFILES)
set(CFILES)
set(PROT_HEADERS nfs_prot.x)
foreach(x_file ${PROT_HEADERS})
    string(REPLACE ".x" ".h" h_file ${x_file})
    string(REPLACE ".x" ".C" c_file ${x_file})
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
endforeach(x_file ${PROT_HEADERS})

ADD_LIBRARY(svc SHARED ${CFILES} ${HFILES})
