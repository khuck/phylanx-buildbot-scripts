#!/bin/bash

rm -f failures

for i in ./bin/* ; do
    rm -rf OTF2_archive
    echo $i 
    if [ $1 == "hpxcxx" ] ; then
        continue
    fi
    if [ $1 == "hpxrun.py" ] ; then
        continue
    fi
    $i
    if [ $? -ne 0 ] ; then
        echo $i >> failures
    fi
done