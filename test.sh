#!/bin/sh

rm -rf build
mkdir build
cd build

## 默认情况 
cmake ..
make
echo "!!! default !!!"
readelf -S gcc64make |grep debug  
./gcc64make
## 默认是debug 执行了assert, 但是不加debug参数 readelf 读不出来debug 信息

## release
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release ..
make
echo "!!! release !!!"
readelf -S gcc64make |grep debug
./gcc64make

## debug
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Debug ..
make
echo "!!! debug !!!"
readelf -S gcc64make |grep debug
./gcc64make

## 32位 默认
rm -rf *
cmake -DUSE_32BITS=1 ..
make
echo "!!! 32 default !!!"
readelf -S gcc64make |grep debug
./gcc64make

## 32位 release
rm -rf *
cmake -DUSE_32BITS=1 -DCMAKE_BUILD_TYPE=Release ..
make
echo "!!! 32 release !!!"
readelf -S gcc64make |grep debug
./gcc64make

## 32位 debug
rm -rf *
cmake -DUSE_32BITS=1 -DCMAKE_BUILD_TYPE=Debug ..
make
echo "!!! 32 debug !!!"
readelf -S gcc64make |grep debug
./gcc64make

## 静态动态库
ls -l ./hello |grep hello
ls -l ./world |grep world
