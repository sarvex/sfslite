project(SFSlite)
cmake_minimum_required(VERSION 2.8.11)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++14")
set(PATH_CPP "/usr/bin/cpp") #$CC -print-prog-name=cpp
set(GETGROUPS_T gid_t)
set(AUTHUNIX_GID_T gid_t)
SET(HAVE_CMSGHDR 1)
SET(PATH_DF 1)
SET(HAVE_UNSETENV 1)

#check_struct_has_member("struct msghdr" msg_control "sys/types.h;sys/socket.h" HAVE_CMSGHDR)
CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/cmake.h.in ${CMAKE_CURRENT_BINARY_DIR}/config.h)
add_definitions(-DHAVE_CONFIG_H)


FIND_PACKAGE(BISON)
# PCRE IS A PAIN
FIND_PATH(PCRE_INCLUDE_DIR NAMES pcre.h)
FIND_LIBRARY(PCRE_LIBRARY NAMES pcre)
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(PCRE DEFAULT_MSG PCRE_LIBRARY PCRE_INCLUDE_DIR)
IF(PCRE_FOUND)
    SET(PCRE_LIBRARIES ${PCRE_LIBRARY})
    SET(PCRE_INCLUDE_DIRS ${PCRE_INCLUDE_DIR})
ELSE(PCRE_FOUND)
    SET(PCRE_LIBRARIES)
    SET(PCRE_INCLUDE_DIRS)
ENDIF(PCRE_FOUND)
MARK_AS_ADVANCED(PCRE_INCLUDE_DIRS PCRE_LIBRARIES)


set(TAME ${CMAKE_BINARY_DIR}/tame/tame)
set(RPCC ${CMAKE_BINARY_DIR}/rpcc/rpcc)

## ALL the Subdirectories

add_subdirectory(async)
add_subdirectory(tame)
add_subdirectory(arpcgen)
add_subdirectory(libtame)
add_subdirectory(libsfs)
add_subdirectory(arpc)
add_subdirectory(rpcc)
add_subdirectory(svc)

#add_subdirectory(tools)
