#!/usr/bin/env bash

#reset
#set -x

rm -fr "$HOME/.jhc/cache"

rm -fr ./*.hl

my_exit() {
	echo "$1"
	exit "$2"
}

type -P m4 > /dev/null || my_exit "this script needs m4 to run, please install m4 package." 123

type -P cpphs > /dev/null || my_exit "this script needs cpphs to run, please install cpphs package." 123

if [ -d dist-newstyle ]; then
    echo "dist-newstyle folder detected; assuming Haskell Cabal"
    run_jhc() { cabal v2-run jhc -- "$@"; }
elif [ -d .stack-work ]; then
    echo ".stack-work folder detected; assuming Haskell Stack"
    run_jhc() { stack exec -- jhc "$@"; }
else
    echo "Neither Cabal nor Stack build folders detected. Assume jhc is on the PATH."
    run_jhc() { jhc "$@"; }
fi

run_jhc -L . --build-hl lib/jhc-prim/jhc-prim.yaml
run_jhc -L . --build-hl lib/jhc/jhc.yaml
run_jhc -L . --build-hl lib/haskell-extras/haskell-extras.yaml
run_jhc -L . --build-hl lib/haskell2010/haskell2010.yaml
run_jhc -L . --build-hl lib/haskell98/haskell98.yaml
run_jhc -L . --build-hl lib/applicative/applicative.yaml
run_jhc -L . --build-hl lib/flat-foreign/flat-foreign.yaml

run_jhc -L . examples/Calendar.hs -o calendar
run_jhc -L . examples/HelloWorld.hs -o hello
run_jhc -L . examples/Primes.hs -o primes
