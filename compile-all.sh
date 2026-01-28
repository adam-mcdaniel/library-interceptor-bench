#!/bin/bash

ROOT=$(pwd)

# Iterate over all subfolders
for dir in */; do
    echo "Compiling $dir"
    cd $dir
    ./compile.sh
    if [ $? -ne 0 ]; then
        echo "Failed to compile $dir"
        exit 1
    fi
    cd $ROOT
done

echo "DONE COMPILING! ALL COMPILED SUCCESSFULLY."