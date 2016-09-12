# CMakeLists.txt
# Build crypt


set(CRYPT_SOURCES
    aes.C arc4.C axprt_crypt.C blowfish.C crypt_prot.C dsa.C elgamal.C
    esign.C fips186.C getkbdnoise.C getsysnoise.C hashcash.C mdblock.C
    modalg.C mpscrub.C mpz_misc.C mpz_raw.C mpz_square.C mpz_xor.C pad.C
    paillier.C password.C pm.C poly.C prng.C rabin.C random_prime.C
    rndseed.C rsa.C seqno.C serial.C sha1.C sha1oracle.C srp.C tiger.C
    tiger_sboxes.C wmstr.C xdr_mpz_t.C schnorr.C ocb.C umac.C rabinpoly.C
    rabin_fprint.C)

set(CRYPT_HEADERS
    aes.h arc4.h axprt_crypt.h bench.h bigint.h blowfish.h crypt.h
    crypthash.h crypt_prot.h dsa.h elgamal.h esign.h fips186.h hashcash.h
    homoenc.h modalg.h paillier.h password.h pm.h poly.h prime.h prng.h
    rabin.h rsa.h seqno.h sha1.h srp.h tiger.h wmstr.h schnorr.h ocb.h
    umac.h rabinpoly.h rabin_fprint.h fprint.h)

include_directories(
    ${CMAKE_BINARY_DIR}/libtame/
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_SOURCE_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_SOURCE_DIR}/arpc/
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/async/)

link_directories(
    ${CMAKE_SOURCE_DIR}/crypt/
    ${CMAKE_BINARY_DIR}/crypt/
    ${CMAKE_BINARY_DIR}/
    ${CMAKE_BINARY_DIR}/libtame/
    ${CMAKE_SOURCE_DIR}/
    ${CMAKE_SOURCE_DIR}/libtame/
    ${CMAKE_BINARY_DIR}/async/
    ${CMAKE_SOURCE_DIR}/async/)
#set(LIBTAME_HEADERS
#     tame_event.h
#     tame_run.h
#     tame_recycle.h
#     tame_weakref.h
#     tame_closure.h
#     tame_rendezvous.h
#     tame_event_ag.h
#     tame_tfork.h
#     tame_tfork_ag.h
#     tame_thread.h
#     tame_typedefs.h
#     tame_slotset.h
#     tame.h
#     tame_pipeline.h
#     tame_lock.h
#     tame_autocb.h
#     tame_trigger.h
#     tame_pc.h
#     tame_io.h
#     tame_aio.h
#     tame_rpcserver.h
#     tame_rpc.h
#     tame_profiler.h
#     tame_pipeline3.h)
#
##set(LIBTAME_SRC
##    ${PROJECT_SOURCE_DIR}/libtame/pipeline.T
##    ${PROJECT_SOURCE_DIR}/libtame/lock.T)
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
#SET(LIBTAME_SOURCE_FILES ${LIBTAME_HEADERS} ${CXXFILES} ${HFILES})
ADD_LIBRARY(crypt SHARED ${CRYPT_SOURCES} ${CRYPT_HEADERS})
