#!/bin/bash
set -e
cd "$(dirname "$0")"
SCHEME=${1:-rootless}
make clean
make package FINALPACKAGE=1
