
## 说明
该程序有3个目的，
1.用来验证 gcc编译在 64 位， 32 位，debug , release , assert 等方面的差异
2.用来验证 cmake构建 动态链接库，静态链接库，多目录的差异
3.用来验证 C 和 C++ 的差异

## 使用
64位编译32需要 apt-get install libc6-dev-i386
32位c++ 需要   cd /usr/lib32 && ln -s libstdc++.so.6 libstdc++.so

执行 testall.sh

## 结论
1. cmake .. 默认是 debug 模式
如果要 cmake -DCMAKE_BUILD_TYPE=Debug .. 传参的话, 
CMakeLists.txt 文件中不能显式定义 set(CMAKE_BUILD_TYPE "RELEASE") 
虽然是 debug 模式 (assert 会执行)，但是 readelf 读不出来 debug 信息

2. cmake -DCMAKE_BUILD_TYPE=Debug .. 指定 debug 模式，readelf 才能读出来 debug 信息
cmake -DCMAKE_BUILD_TYPE=Debug .. 的 debug 大小写不敏感
readelf -S gcc64make |grep debug 的 debug 大小写敏感，是小写 debug

3. assert 只有在定义了 NDEBUG 宏的情况下才会失效
而不同的编译器对 release 模式下，NDEBUG 宏的定义不同，所以需要手动加上 -DNDEBUG
C编译器 release 模式的默认选项 CMAKE_C_FLAGS_RELEASE 加了 -DNDEBUG
C++编译器 release 模式的默认选项 CMAKE_CXX_FLAGS_RELEASE 没有加 -DNDEBUG, 所以assert在c++的release版本中依然生效，需要加上 -DNDEBUG

4. cmake 根据 .c 和 .cpp 自动确定是用 c编译器，还是用 c++编译器
```bash
c++编译器 自动识别.cpp /usr/bin/c++ -> /etc/alternatives/c++ -> /usr/bin/g++
c编译器   自动识别.c   /usr/bin/cc  -> /etc/alternatives/cc  -> /usr/bin/gcc
```
gcc 将.c文件视为c文件，而 g++ 同时将.c和.cpp文件视为c++文件
使用 g++ 需要安装 build-essential
所以 CMakeLists.txt 文件中 project(gcc64make) 无需在gcc64make后面指定编译器

5. 设置了 SET(CMAKE_CXX_STANDARD 11) 就不用再设置 SET(CMAKE_CXX_FLAGS -std=c++11)