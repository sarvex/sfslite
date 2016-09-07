find_package(BISON)
find_package(FLEX)

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-register -DHAVE_CONFIG_H -DEXECDIR=\"/usr/local/lib/sfslite-1.2\" -DETCDIR=\"/etc/sfs\" -DDATADIR=\"/usr/local/share/sfslite\" -DPIDDIR=\"/var/run\" -DSFSDIR=\"/var/sfs\"  -g -O2 -Wall -Wno-mismatched-tags -Wno-overloaded-virtual -Wno-unused-private-field --std=gnu++0x ")


include_directories(
    ${CMAKE_CURRENT_BINARY_DIR}/rpcc/
    ${CMAKE_BINARY_DIR}/rpcc/
    ${CMAKE_SOURCE_DIR}/rpcc/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/async/
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/)

link_directories(
    ${CMAKE_BINARY_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_BINARY_DIR}/rpcc/
    ${CMAKE_SOURCE_DIR}/rpcc/
    ${CMAKE_BINARY_DIR}/async/)

add_custom_command(
    OUTPUT ${CMAKE_SOURCE_DIR}/rpcc/parse.cc
    COMMAND ${BISON_EXECUTABLE}
    ARGS -d ${CMAKE_SOURCE_DIR}/rpcc/parse.yy -o ${CMAKE_SOURCE_DIR}/rpcc/parse.cc
    DEPENDS ${CMAKE_SOURCE_DIR}/rpcc/parse.yy)

add_custom_command(
    OUTPUT ${CMAKE_SOURCE_DIR}/rpcc/scan.cc
    COMMAND ${FLEX_EXECUTABLE}
    ARGS -o ${CMAKE_SOURCE_DIR}/rpcc/scan.cc ${CMAKE_SOURCE_DIR}/rpcc/scan.ll
    DEPENDS ${CMAKE_SOURCE_DIR}/rpcc/scan.ll)

set(RPC_FILES
    parse.h rpcc.C parse.cc scan.cc rpcc.h genheader.C genpyc.C genpython.C gencfile.C)

add_executable(rpcc ${RPC_FILES})
target_link_libraries(rpcc PUBLIC async pcre resolv nsl)
