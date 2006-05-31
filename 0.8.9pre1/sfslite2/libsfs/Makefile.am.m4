dnl $Id$
dnl
dnl Process this file with GNU m4 to get Makefile.am.
dnl (Using m4 greatly simplifies the rules for autogenerated RPC files.)
dnl
## Process this file with automake to produce Makefile.in
## Do not edit this file directly.  It is generated from Makefile.am.m4

ARPCGEN = $(top_builddir)/uvfs/arpcgen/arpcgen
SVCDIR = $(top_srcdir)/svc

if USE_AUTH_HELPER
AUTH_HELPER = auth_helper
endif

lib_LIBRARIES = libsfs.a
sfsexec_PROGRAMS = pathinfo suidconnect $(AUTH_HELPER)
noinst_PROGRAMS = tst

dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl
dnl                                                                 dnl
dnl                MACROS FOR AUTOGENERATED RPC FILES               dnl
dnl                                                                 dnl
dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl

define(`rpcmk_headers',)dnl
define(`rpcmk_sources',)dnl
define(`rpcmk_built', `rpcmk_headers rpcmk_sources')dnl
define(`rpcmk',
changequote([[, ]])dnl
[[dnl
define(`rpcmk_headers', rpcmk_headers $1.h)dnl
define(`rpcmk_sources', rpcmk_sources $1.c)dnl
$1.h: $(SVCDIR)/$1.x
	@rm -f $`'@
	-$(ARPCGEN) -r sfs-internal.h -h $(SVCDIR)/$1.x -o `$'@ || rm -f $`'@
$1.c: $(SVCDIR)/$1.x
	@rm -f $`'@
	-$(ARPCGEN) -c $(SVCDIR)/$1.x -o `$'@ || rm -f $`'@
$1.o: $1.c $1.h
	$(COMPILE) -c @NW@ $1.c
]]changequote)dnl

dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl
dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl

rpcmk(nfs3_prot)
rpcmk(nfs3exp_prot)
rpcmk(sfs_prot)
dnl rpcmk(sfsro_prot)
rpcmk(sfsagent)
rpcmk(auth_helper_prot)

nfs3_prot.o: nfs3exp_prot.h

$(DEP_FILES): rpcmk_headers

rwfd.c:
	$(LN_S) $(top_srcdir)/async/rwfd.c rwfd.c
suidprotect.c:
	$(LN_S) $(top_srcdir)/async/suidprotect.c suidprotect.c
authunixint.c:
	$(LN_S) $(top_srcdir)/arpc/authunixint.c authunixint.c

EXTRA_DIST = Makefile.am.m4 .cvsignore \
	auth_helper_common.c auth_helper_pam.c auth_helper_bsd.c

libsfs_a_SOURCES = rpcmk_sources \
rwfd.c suidprotect.c authunixint.c \
devcon.c hashtab.c sfsops.c sfspaths.c srpc.c xdr_misc.c suio.c

DEPEND_ON_MAKEFILE = devgetcon.o sfspaths.o
$(DEPEND_ON_MAKEFILE): Makefile

include_HEADERS = sfs.h
sfsinclude_HEADERS = sfs-internal.h auth_helper.h
noinst_HEADERS = hashtab.h queue.h suio.h xdr_suio.h

suidconnect_SOURCES = suidconnect.c
suidconnect_LDADD = libsfs.a 

pathinfo_SOURCES = pathinfo.c
pathinfo_LDADD = libsfs.a

auth_helper_SOURCES = auth_helper.c auth_helper_common.c
auth_helper_LDADD = libsfs.a $(AUTH_HELPER_LIB)

# Ugh... this is the only way I could get automake to work
auth_helper.c: $(srcdir)/$(AUTH_HELPER_STYLE) Makefile
	@rm -f $@
	$(LN_S) $(srcdir)/$(AUTH_HELPER_STYLE) $@

tst_SOURCES = tst.c
tst_LDADD = libsfs.a

dist-hook:
	cd $(distdir) && rm -f rwfd.c authunixint.c rpcmk_built

.PHONY: rpcclean
rpcclean:
	rm -f rpcmk_built

install-exec-hook:
	-chgrp @sfsgroup@ $(DESTDIR)$(sfsexecdir)/suidconnect \
	   && chmod 2555 $(DESTDIR)$(sfsexecdir)/suidconnect

CLEANFILES = core *.core *~ *.rpo rpcmk_built \
	authunixint.c rwfd.c auth_helper.c
MAINTAINERCLEANFILES = Makefile.in Makefile.am

$(srcdir)/Makefile.am: $(srcdir)/Makefile.am.m4
	@rm -f $(srcdir)/Makefile.am~
	$(M4) $(srcdir)/Makefile.am.m4 > $(srcdir)/Makefile.am~
	mv -f $(srcdir)/Makefile.am~ $(srcdir)/Makefile.am
