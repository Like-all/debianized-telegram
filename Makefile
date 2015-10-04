FETCH=/usr/bin/curl -L
UNPACK=/bin/tar -xf

FETCHDIR=downloads
PREFIX?=$(DESTDIR)/usr
BINDIR?=$(PREFIX)/bin

DEBARCH=$(shell dpkg --print-architecture)

ifeq "$(DEBARCH)" "amd64"
FETCHURL=https://tdesktop.com/linux
else ifeq "$(DEBARCH)" "i386"
FETCHURL=https://tdesktop.com/linux32
endif

all: telegram

telegram: Makefile
	mkdir -p $(FETCHDIR)
	cd $(FETCHDIR) && \
	$(FETCH) $(FETCHURL) > telegram.tar.xz && \
	$(UNPACK) telegram.tar.xz && \
	mv Telegram/Telegram Telegram/telegram

clean:
	rm -fr $(FETCHDIR)

install:
	mkdir -p $(BINDIR)
	install -m755 $(FETCHDIR)/Telegram/telegram $(BINDIR)
