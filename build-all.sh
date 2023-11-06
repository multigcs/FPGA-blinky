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

echo "| Part | Toolchain | duration(user) | duration(system) | files | bitstream |" > duration.table
echo "| --- | --- | --- | --- | --- | --- |" >> duration.table

for F in `ls -d */`
do
    if ! find "$F" | grep "rio.bit$\|rio.bin$\|project.fs$\|rio.fs$\|rio.sof$\|rio_build.bit$" > $F/output.file
    then
        echo ""
        echo "FAILED: $F"
        echo ""
    fi

    if test -e $F/rio.ncd
    then
        TOOLCHAIN="ise/webpack"
    elif test -e $F/impl/pnr/project.fs
    then
        TOOLCHAIN="gowin"
    elif test -e $F/yosys.log
    then
        TOOLCHAIN="yosys+nextpnr"
    elif test -e $F/rio.sof
    then
        TOOLCHAIN="quartus"
    elif test -e $F/build/rio_build.bit
    then
        TOOLCHAIN="quartus"
    elif test -e $F/vivado.log
    then
        TOOLCHAIN="vivado"
    else
        TOOLCHAIN="???"
        echo "FAILED / UNKNOWN TOOLCHAIN"
        exit 1
    fi

    FAMILY=`grep "^FAMILY " $F/Makefile | cut -d"=" -f2`
    PART=`grep "^PART \|^TYPE \|^DEVICE " $F/Makefile | cut -d"=" -f2`
    FILES=`grep "^VERILOGS" $F/Makefile | cut -d"=" -f2`
    BITSTEAM=`cat $F/output.file | sed "s|^$F||g"`
    DURATION=`cat $F/time.log | grep "user " | awk '{print $1" | "$2}' | sed "s|user|s|g" | sed "s|system|s|g"`
    echo "| $FAMILY$PART | $TOOLCHAIN | $DURATION | $FILES | $BITSTEAM |" >> duration.table
done
echo "" >> duration.table

cat duration.table

rm */output.file */time.log
