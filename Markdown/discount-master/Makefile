CC=cc -Wno-implicit-int -I.
LFLAGS=-L.
CFLAGS=-g
AR=/usr/bin/ar
RANLIB=/usr/bin/ranlib

BINDIR=./build/bin
MANDIR=./build/man
LIBDIR=./build/lib
INCDIR=./build/include
#PKGDIR=$(LIBDIR)/pkgconfig

PGMS=markdown
SAMPLE_PGMS=mkd2html makepage
SAMPLE_PGMS+= theme
MKDLIB=libmarkdown
OBJS=mkdio.o markdown.o dumptree.o generate.o \
     resource.o docheader.o version.o toc.o css.o \
     xml.o Csio.o xmlpage.o basename.o emmatch.o \
     github_flavoured.o setup.o tags.o html5.o flags.o \
      
TESTFRAMEWORK=echo cols branch

# modules that markdown, makepage, mkd2html, &tc use
COMMON=pgm_options.o gethopt.o notspecial.o

MAN3PAGES=mkd-callbacks.3 mkd-functions.3 markdown.3 mkd-line.3

all: $(PGMS) $(SAMPLE_PGMS) $(TESTFRAMEWORK)

install: $(PGMS) $(DESTDIR)$(BINDIR) $(DESTDIR)$(LIBDIR) $(DESTDIR)$(INCDIR) $(DESTDIR)$(PKGDIR)
	/usr/bin/install -s -m 755 $(PGMS) $(DESTDIR)$(BINDIR)
	./librarian.sh install libmarkdown VERSION $(DESTDIR)$(LIBDIR)
	/usr/bin/install -m 444 mkdio.h $(DESTDIR)$(INCDIR)
	#/usr/bin/install -m 444 $(MKDLIB).pc $(DESTDIR)$(PKGDIR)

install.everything: install install.samples install.man

install.samples: $(SAMPLE_PGMS) install $(DESTDIR)$(BINDIR)
	/Users/daizhirui/Downloads/discount-master/config.md $(DESTDIR)$(MANDIR)/man1
	for x in $(SAMPLE_PGMS); do \
	    /usr/bin/install -s -m 755 $$x $(DESTDIR)$(BINDIR)/$(SAMPLE_PFX)$$x; \
	    /usr/bin/install -m 444 $$x.1 $(DESTDIR)$(MANDIR)/man1/$(SAMPLE_PFX)$$x.1; \
	done

install.man:
	/Users/daizhirui/Downloads/discount-master/config.md $(DESTDIR)$(MANDIR)/man3
	/usr/bin/install -m 444 $(MAN3PAGES) $(DESTDIR)$(MANDIR)/man3
	for x in mkd_line mkd_generateline; do \
	    ( echo '.\"' ; echo ".so man3/mkd-line.3" ) > $(DESTDIR)$(MANDIR)/man3/$$x.3;\
	done
	for x in mkd_in mkd_string; do \
	    ( echo '.\"' ; echo ".so man3/markdown.3" ) > $(DESTDIR)$(MANDIR)/man3/$$x.3;\
	done
	for x in mkd_compile mkd_css mkd_generatecss mkd_generatehtml mkd_cleanup mkd_doc_title mkd_doc_author mkd_doc_date; do \
	    ( echo '.\"' ; echo ".so man3/mkd-functions.3" ) > $(DESTDIR)$(MANDIR)/man3/$$x.3; \
	done
	/Users/daizhirui/Downloads/discount-master/config.md $(DESTDIR)$(MANDIR)/man7
	/usr/bin/install -m 444 markdown.7 mkd-extensions.7 $(DESTDIR)$(MANDIR)/man7
	/Users/daizhirui/Downloads/discount-master/config.md $(DESTDIR)$(MANDIR)/man1
	/usr/bin/install -m 444 markdown.1 $(DESTDIR)$(MANDIR)/man1

install.everything: install install.man

$(DESTDIR)$(BINDIR):
	/Users/daizhirui/Downloads/discount-master/config.md $(DESTDIR)$(BINDIR)

$(DESTDIR)$(INCDIR):
	/Users/daizhirui/Downloads/discount-master/config.md $(DESTDIR)$(INCDIR)

$(DESTDIR)$(LIBDIR):
	/Users/daizhirui/Downloads/discount-master/config.md $(DESTDIR)$(LIBDIR)

#$(DESTDIR)$(PKGDIR):
#	/Users/daizhirui/Downloads/discount-master/config.md $(DESTDIR)$(PKGDIR)

version.o: version.c VERSION branch
	$(CC) $(CFLAGS) -DBRANCH=`./branch` -DVERSION=\"`cat VERSION`\" -c version.c

VERSION:
	@true

tags.o: tags.c cstring.h tags.h blocktags

blocktags: mktags
	./mktags > blocktags

# example programs
theme:  theme.o $(COMMON) $(MKDLIB) mkdio.h
	$(CC) $(CFLAGS) $(LFLAGS) -o theme theme.o $(COMMON) -lmarkdown 


mkd2html:  mkd2html.o $(MKDLIB) mkdio.h gethopt.h $(COMMON)
	$(CC) $(CFLAGS) $(LFLAGS) -o mkd2html mkd2html.o $(COMMON) -lmarkdown 

markdown: main.o $(COMMON) $(MKDLIB)
	$(CC) $(CFLAGS) $(LFLAGS) -o markdown main.o $(COMMON) -lmarkdown 
	
makepage:  makepage.c $(COMMON) $(MKDLIB) mkdio.h
	$(CC) $(CFLAGS) $(LFLAGS) -o makepage makepage.c $(COMMON) -lmarkdown 

pgm_options.o: pgm_options.c mkdio.h config.h
	$(CC) $(CFLAGS) -I. -c pgm_options.c

notspecial.o: notspecial.c
	$(CC) $(CFLAGS) -I. -c notspecial.c

gethopt.o: gethopt.c
	$(CC) $(CFLAGS) -I. -c gethopt.c

main.o: main.c mkdio.h config.h
	$(CC) $(CFLAGS) -I. -c main.c

$(MKDLIB): $(OBJS)
	./librarian.sh make $(MKDLIB) VERSION $(OBJS)

verify: echo tools/checkbits.sh
	@./echo -n "headers ... "; tools/checkbits.sh && echo "GOOD"

test:	$(PGMS) $(TESTFRAMEWORK) verify
	@for x in tests/*.t; do \
	    HERE=`pwd` sh $$x || exit 1; \
	done

branch: tools/branch.c config.h
	$(CC) -o branch tools/branch.c
cols:   tools/cols.c config.h
	$(CC) -o cols tools/cols.c
echo:   tools/echo.c config.h
	$(CC) -o echo tools/echo.c
	
clean:
	rm -f $(PGMS) $(TESTFRAMEWORK) $(SAMPLE_PGMS) *.o
	rm -f $(MKDLIB) `./librarian.sh files $(MKDLIB) VERSION`

distclean spotless: clean
	rm -fr *.dSYM Makefile version.c mkdio.h config.cmd config.sub config.h config.mak config.md librarian.sh config.log ./mktags ./blocktags

Csio.o: Csio.c cstring.h amalloc.h config.h markdown.h
amalloc.o: amalloc.c
basename.o: basename.c config.h cstring.h amalloc.h markdown.h
css.o: css.c config.h cstring.h amalloc.h markdown.h
docheader.o: docheader.c config.h cstring.h amalloc.h markdown.h
dumptree.o: dumptree.c markdown.h cstring.h amalloc.h config.h
emmatch.o: emmatch.c config.h cstring.h amalloc.h markdown.h
generate.o: generate.c config.h cstring.h amalloc.h markdown.h
main.o: main.c config.h amalloc.h
pgm_options.o: pgm_options.c pgm_options.h config.h amalloc.h
makepage.o: makepage.c
markdown.o: markdown.c config.h cstring.h amalloc.h markdown.h
mkd2html.o: mkd2html.c config.h mkdio.h cstring.h amalloc.h
mkdio.o: mkdio.c config.h cstring.h amalloc.h markdown.h
resource.o: resource.c config.h cstring.h amalloc.h markdown.h
theme.o: theme.c config.h mkdio.h cstring.h amalloc.h
toc.o: toc.c config.h cstring.h amalloc.h markdown.h
version.o: version.c config.h
xml.o: xml.c config.h cstring.h amalloc.h markdown.h
xmlpage.o: xmlpage.c config.h cstring.h amalloc.h markdown.h
setup.o: setup.c config.h cstring.h amalloc.h markdown.h
github_flavoured.o: github_flavoured.c config.h cstring.h amalloc.h markdown.h
gethopt.o: gethopt.c gethopt.h
h1title.o: h1title.c markdown.h
notspecial.o: notspecial.c config.h
