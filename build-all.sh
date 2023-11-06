#!/bin/bash
#
#


for F in `ls -d */`
do
    echo "######### $F #########"
    (
        cd  $F
        make clean
    )
done

for F in `ls -d */`
do
    echo "######### $F #########"
    (
        cd  $F
        if ! /usr/bin/time -o time.log make all
        then
            echo ""
            echo "#### build failed: $F"
            echo ""
        fi
    )
done

echo ""
echo "--------------------------------------------------------------------"
echo ""
for F in `ls -d */`
do
    echo "######### $F #########"
    if ! find "$F" | grep "rio.bit$\|rio.bin$\|project.fs$\|rio.fs$\|rio.sof$\|rio_build.bit$"
    then
        echo ""
        echo "#### FAILED ####"
        echo ""
    fi
done




