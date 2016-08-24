find_package(BISON)
find_package(FLEX)

BISON_TARGET(Parser ${CMAKE_SOURCE_DIR}/rpcc/parse.yy ${CMAKE_CURRENT_BINARY_DIR}/parse.cc)
FLEX_TARGET(Scanner ${CMAKE_SOURCE_DIR}/rpcc/scan.ll  ${CMAKE_CURRENT_BINARY_DIR}/scan.cc)
ADD_FLEX_BISON_DEPENDENCY(Scanner Parser)

include_directories(
    ${CMAKE_CURRENT_BINARY_DIR}/rpcc/
    ${CMAKE_BINARY_DIR}/rpcc/
    ${CMAKE_SOURCE_DIR}/rpcc/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/async/
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/)

link_directories(
    ${CMAKE_BINARY_DIR}/rpcc/
    ${CMAKE_SOURCE_DIR}/rpcc/
    ${CMAKE_BINARY_DIR}/async/)

set(RPC_FILES
    rpcc.C
    genheader.C
    genpyc.C
    genpython.C
    gencfile.C)

add_executable(
    rpcc
    ${RPC_FILES}
    ${BISON_Parser_OUTPUTS}
    ${FLEX_Scanner_OUTPUTS})

target_link_libraries(rpcc PUBLIC ${FLEX_LIBRARIES} ${BISON_LIBRARIES} async pcre resolv )
