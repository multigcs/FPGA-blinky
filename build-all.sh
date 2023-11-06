#!/bin/bash
#
#


for F in `ls -d */`
do
    echo "######### $F #########"
    (
        cd  $F
        if ! make all
        then
            echo ""
            echo "#### build failed: $F"
            echo ""
        fi
    )
done

for F in `ls -d */`
do
    echo "######### $F #########"
    if ! find "$F" | grep "rio.bit$\|rio.bin$\|project.fs$\|rio.fs$\|rio.sof$"
    then
        echo ""
        echo "#### FAILED ####"
        echo ""
    fi
done




