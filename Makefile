VERSION = 0.1

CC      ?= gcc
LIBS     = -lX11 -lXinerama -lXft -lXrender -lfreetype -lz -lfontconfig
CFLAGS  += -std=c99 -pedantic -Wall -Wextra -I/usr/include/freetype2
CFLAGS  += -DXINERAMA -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\"
LDFLAGS +=

PREFIX   ?= /usr/local
BINPREFIX = $(PREFIX)/bin
MANPREFIX = $(PREFIX)/share/man

DM_SRC = dmenu3.c draw.c
DM_OBJ = $(DM_SRC:.c=.o)

all: CFLAGS += -Os
all: LDFLAGS += -s
all: dmenu3

debug: CFLAGS += -g -O0 -DDEBUG
debug: dmenu3

.c.o:
	$(CC) $(CFLAGS) -c -o $@ $<

dmenu3: $(DM_OBJ)
	$(CC) -o $@ $(DM_OBJ) $(LDFLAGS) $(LIBS)

install:
	mkdir -p "$(DESTDIR)$(BINPREFIX)"
	cp -p dmenu3 "$(DESTDIR)$(BINPREFIX)"
	mkdir -p "$(DESTDIR)$(MANPREFIX)"/man1
	cp -p dmenu3.1 "$(DESTDIR)$(MANPREFIX)"/man1

uninstall:
	rm -f "$(DESTDIR)$(BINPREFIX)"/dmenu3
	rm -f "$(DESTDIR)$(MANPREFIX)"/man1/dmenu3.1

clean:
	rm -f $(DM_OBJ) dmenu3

.PHONY: all debug install uninstall clean