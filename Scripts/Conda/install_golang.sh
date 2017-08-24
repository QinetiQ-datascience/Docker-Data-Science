#!/bin/bash
set -e

cd /tmp && wget https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz && tar -C /usr/local -xzf go$GOLANG_VERSION.linux-amd64.tar.gz
# TODO Fix Checksum

go get golang.org/x/tools/cmd/goimports

go get -tags zmq_4_x github.com/gopherds/gophernotes