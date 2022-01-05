#!/bin/sh

test(){
#默认简单测试 c和c++ 混编。 要测试全部的 release debug 64 32功能，把下面的注释都放开 

#sh test.sh 64
#sh test.sh 64 Release
sh test.sh 64 Debug

#sh test.sh 32
#sh test.sh 32 Release
#sh test.sh 32 Debug 
}

echo "\n\n!!! now test c main & c lib !!!\n\n"
test

echo "\n\n!!! now test c main & c++ lib !!!\n\n"
cd hello && mv hello.c hello.cpp && cd ../
cd world && mv world.c world.cpp && cd ../

test

echo "\n\n!!! now test c++ main & c++ lib !!!\n\n"
mv gcc64_make.c gcc64_make.cpp

test

echo "\n\n!!! now test c++ main & c lib !!!\n\n"
cd hello && mv hello.cpp hello.c && cd ../
cd world && mv world.cpp world.c && cd ../

test

echo "\n\n!!! reset to c main !!!\n\n"
mv gcc64_make.cpp gcc64_make.c

#c++编译器 自动识别.cpp /usr/bin/c++ -> /etc/alternatives/c++ -> /usr/bin/g++
#c编译器   自动识别.c   /usr/bin/cc  -> /etc/alternatives/cc  -> /usr/bin/gcc
