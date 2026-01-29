#!/bin/bash

ROOT=$(pwd)

# Iterate over all subfolders
for dir in */; do
    echo "Compiling $dir"
    cd $dir
    if [ ! -f ./compile.sh ]; then
        echo "No compile.sh found in $dir, skipping."
        cd $ROOT
        continue
    fi
    ./compile.sh
    if [ $? -ne 0 ]; then
        echo "Failed to compile $dir"
        exit 1
    fi
    cd $ROOT
done

cd library-interceptors/perf-libs-tools && ./install.sh --prefix . --rocm-version 6.4.1
cd $ROOT

echo "DONE COMPILING! ALL COMPILED SUCCESSFULLY."