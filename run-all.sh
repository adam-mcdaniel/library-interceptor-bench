#!/bin/bash

ROOT=$(pwd)

# Iterate over all subfolders
for dir in */; do
    echo "Running $dir"
    cd $dir
    ./run.sh &
    if [ $? -ne 0 ]; then
        echo "Failed to compile $dir"
        exit 1
    fi
    cd $ROOT
done

wait
if [ $? -ne 0 ]; then
    echo "One of the runs failed"
    exit 1
fi

echo "DONE COMPILING! ALL COMPILED SUCCESSFULLY."