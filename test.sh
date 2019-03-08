#!/bin/sh

rm -rf build
mkdir build
cd build

## 默认情况 
echo "\n\n!!! default !!!"
cmake ..
make
readelf -S gcc64make |grep debug  
./gcc64make
## 默认是debug 执行了assert, 但是不加debug参数 readelf 读不出来debug 信息

## release
echo "\n\n!!! release !!!"
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release ..
make
readelf -S gcc64make |grep debug
./gcc64make

## debug
echo "\n\n!!! debug !!!"
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Debug ..
make
readelf -S gcc64make |grep debug
./gcc64make

## 32位 默认
echo "\n\n!!! 32 default !!!"
rm -rf *
cmake -DUSE_32BITS=1 ..
make
readelf -S gcc64make |grep debug
./gcc64make

## 32位 release
echo "\n\n!!! 32 release !!!"
rm -rf *
cmake -DUSE_32BITS=1 -DCMAKE_BUILD_TYPE=Release ..
make
readelf -S gcc64make |grep debug
./gcc64make

## 32位 debug
echo "\n\n!!! 32 debug !!!"
rm -rf *
cmake -DUSE_32BITS=1 -DCMAKE_BUILD_TYPE=Debug ..
make
readelf -S gcc64make |grep debug
./gcc64make

## 静态动态库
ls -l ./hello |grep hello
ls -l ./world |grep world
