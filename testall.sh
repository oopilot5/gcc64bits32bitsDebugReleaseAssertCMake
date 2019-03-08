#!/bin/sh

sh test.sh

echo "!!! now test c++ !!!"
mv gcc64_make.c gcc64_make.cpp
cd hello && mv hello.c hello.cpp && cd ../
cd world && mv world.c world.cpp && cd ../

sh test.sh

mv gcc64_make.cpp gcc64_make.c
cd hello && mv hello.cpp hello.c && cd ../
cd world && mv world.cpp world.c && cd ../

#c++编译器 自动识别.cpp /usr/bin/c++ -> /etc/alternatives/c++ -> /usr/bin/g++
#c编译器   自动识别.c   /usr/bin/cc  -> /etc/alternatives/cc  -> /usr/bin/gcc
