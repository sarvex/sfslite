dnl $Id$
dnl
dnl Process this file with GNU m4 to get Makefile.am.
dnl (Using m4 greatly simplifies the rules for autogenerated RPC files.)
dnl
## Process this file with automake to produce Makefile.in
## Do not edit this file directly.  It is generated from Makefile.am.m4

LDADD =  $(LIBARPC) $(LIBASYNC)  

dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl
dnl                                                                 dnl
dnl                MACROS FOR TAMED FILES                           dnl
dnl                                                                 dnl
dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl

SUFFIXES = .T .x .C .h
.T.C:
	-$(TAME) -o $@ $< || rm -f $@
.x.h:
	-$(RPCC) -h $< || rm -f $@
.x.C:
	-$(RPCC) -c $< || rm -f $@

define(`tame_exes')dnl
define(`tame_dist')dnl
define(`tame_clean')dnl

define(`tame_src',
changequote([[, ]])dnl
[[dnl
define(`tame_exes', tame_exes $1)dnl
define(`tame_dist', tame_dist $1.T)dnl
define(`tame_clean', tame_clean $1.C)dnl
$1.C: $(srcdir)/$1.T
]]changequote)dnl

define(`tame_standalone',
changequote([[, ]])dnl
[[dnl
tame_src($1)dnl
$1_SOURCES = $1.C 
$1_DEPENDENCIES = $(LIBASYNC)
]]changequote)dnl

define(`tame_rpcclient',
changequote([[, ]])dnl
[[
tame_src($1)dnl
$1_SOURCES = $1.C ex_prot.C
$1.o: ex_prot.h
$1_DEPENDENCIES = $(LIBASYNC) $(LIBARPC)
]]changequote)dnl

dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl
dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl

tame_standalone(bench1)
tame_standalone(ex1)
tame_rpcclient(ex2)
tame_rpcclient(ex3)
tame_rpcclient(ex3b)
tame_rpcclient(ex4)
tame_rpcclient(ex5)
tame_standalone(ex6)
tame_standalone(ex7)
tame_standalone(ex8)
tame_rpcclient(ex9)
tame_rpcclient(ex10)
tame_rpcclient(ex11)
tame_standalone(ex12)
tame_standalone(tcpconnect)
tame_standalone(buggy1a)
tame_standalone(buggy1b)
tame_standalone(buggy1c)
tame_rpcclient(buggy10)
tame_standalone(null)
tame_standalone(test)
tame_standalone(buggy2)

dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl
dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl dnl

noinst_PROGRAMS = tame_exes exsrv

exsrv_SOURCES = exsrv.C ex_prot.C

RPC_AUTOGEN_FILES = ex_prot.C ex_prot.h

ex_prot.C: ex_prot.x
ex_prot.h: ex_prot.x
ex_prot.o: ex_prot.h
ex_prot.lo: ex_prot.h

.PHONY: bldclean rpclean
bldclean:
	rm -f $(CLEANFILES)
rpcclean:
	rm -f $(RPC_AUTOGEN_FILES)

CLEANFILES = core *.core $(RPC_AUTOGEN_FILES) tame_clean 

dist-hook:
	cd $(distdir) && rm -f $(CLEANFILES) 

EXTRA_DIST = Makefile.am.m4 .cvsignore tame_dist ex_prot.x
MAINTAINERCLEANFILES = Makefile.in Makefile.am

$(srcdir)/Makefile.am: $(srcdir)/Makefile.am.m4
	@rm -f $(srcdir)/Makefile.am~
	$(M4) $(srcdir)/Makefile.am.m4 > $(srcdir)/Makefile.am~
	mv -f $(srcdir)/Makefile.am~ $(srcdir)/Makefile.am
