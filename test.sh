#!/bin/sh

rm -rf build
mkdir build
cd build

bitflag=''
if [ $1 = 32 ]
then
    bitflag='-DUSE_32BITS=1'
fi

buildtype="-DCMAKE_BUILD_TYPE=$2"

## 默认情况 
echo "\n bitflag:${bitflag} buildtype:${buildtype}\n"
cmake ${bitflag} ${buildtype} ..
make
echo "\n pring debug info:\n" 
readelf -S gcc64make |grep debug
echo "\n pring program run info:\n" 
./gcc64make

## 静态动态库
ls -l ./hello |grep hello
ls -l ./world |grep world