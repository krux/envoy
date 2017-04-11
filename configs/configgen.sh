#!/bin/bash

set -e

SCRIPT_DIR=`dirname $0`
BUILD_DIR=/tmp/configgen
OUT_DIR=$1
shift

if [ ! -d $BUILD_DIR/venv ]; then
  virtualenv $BUILD_DIR/venv
  $BUILD_DIR/venv/bin/pip install -r $SCRIPT_DIR/requirements.txt
fi

mkdir -p $OUT_DIR
$BUILD_DIR/venv/bin/python $SCRIPT_DIR/configgen.py $SCRIPT_DIR $OUT_DIR
cp $SCRIPT_DIR/google_com_proxy.json $OUT_DIR
cp $* $OUT_DIR

cd $OUT_DIR
tar -cvf example_configs.tar *.json
