#!/bin/sh
# Tests.

mak() {
  make "$@"
  echo
}

mak run
mak ARGS= run
mak ARGS="tests/" run

mak ARGS="sh tests/" run
mak ARGS="py tests/" run
mak ARGS="swift tests/" run

mak ARGS="'py md' tests/" run
