# vim: set syntax=makefile ff=unix fileencoding=utf-8 noexpandtab ts=4 sw=4:

GOPATH = /tmp/ssh-s3-helper.go

EXIST_GO = $(shell which go > /dev/null && echo 1)

DEST = /usr/local/bin/ssh-s3-helper

all: ssh-s3-helper

ssh-s3-helper:
ifeq ($(EXIST_GO),1)
	mkdir -p $(GOPATH)
	GOPATH=$(GOPATH) go get github.com/zieckey/goini
	GOPATH=$(GOPATH) go build ssh-s3-helper.go
else
	cp -v ssh-s3-helper.sh ssh-s3-helper
endif

clean:
	rm -f ssh-s3-helper
	rm -rf $(GOPATH)

install:
	install -m 555 -o root -g root ./ssh-s3-helper $(DEST)

uninstall:
	rm -f $(DEST)

