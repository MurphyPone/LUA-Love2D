#!/bin/bash
#Name this file 'run.sh' on Linux and 'run.command' on OS X.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
if [ `uname -s` == "Darwin" ];
then open -n -a love ./
else love ./
fi
