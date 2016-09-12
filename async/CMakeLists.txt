# CMakeLists.txt
# Build async

## Include and links
include_directories(
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_BINARY_DIR}/tame/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/tame/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_SOURCE_DIR}/async/)

link_directories(
    ${CMAKE_SOURCE_DIR}/async/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_BINARY_DIR}/tame/)

set (ASYNC_LIBS
    aiod.h aiod_prot.h aios.h amisc.h arena.h array.h async.h backoff.h
    bbuddy.h bitvec.h callback.h cbuf.h dns.h dnsimpl.h dnsparse.h err.h
    fdlim.h ihash.h init.h itree.h keyfunc.h list.h msb.h opnew.h
    parseopt.h qhash.h refcnt.h rxx.h serial.h stllike.h str.h
    suio++.h sysconf.h union.h vatmpl.h vec.h rwfd.h litetime.h
    corebench.h qtailq.h sfs_select.h rclist.h dynenum.h
    rctailq.h rctree.h sfs_bundle.h alog2.h sfs_profiler.h wide_str.h
    sfs_const.h sfs_assert.h weak_template.h)

set (ASYNC_SRCS
    arandom.c clock_gettime.c flock.c rwfd.c stktrace.c suidprotect.c
    aerr.C aio.C aios.C arena.C armor.C bbuddy.C cbuf.C convertint.C
    core.C daemonize.C dns.C dnsparse.C err.C fdwait.C ifchg.C
    ihash.C itree.C lockfile.C malloc.C msb.C myaddrs.C myname.C
    parseopt.C pipe2str.C refcnt.C rxx.C sigio.C socket.C spawn.C str.C
    str2file.C straux.C suio++.C suio_vuprintf.C tcpconnect.C litetime.C
    select.C select_std.C select_epoll.C select_kqueue.C dynenum.C
    vec.C bundle.C alog2.C leakcheck.C profiler.C wide_str.C const.C)

add_library(async ${ASYNC_LIBS} ${ASYNC_SRCS})
