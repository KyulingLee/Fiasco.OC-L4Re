#!/bin/sh

mkdir build

cd Fiasco.OC

if [ ! -d ../build/Fiasco.OC ]
then
    make BUILDDIR=../build/Fiasco.OC || exit 1
fi

cd ../build/Fiasco.OC || exit 1
if [ ! -f globalconfig.h ]
then
    make config || exit 1
fi
make -j8 || exit 1

cd ../../L4Re
if [ ! -d ../build/L4Re ]
then
    make B=../build/L4Re
fi

cd ../build/L4Re || exit 1
if [ ! -f .l4_configured ]
then
    make config || exit 1
    touch .l4_configured
fi
make -j8 || exit 1
make qemu MODULE_SEARCH_PATH=$PWD/../Fiasco.OC
