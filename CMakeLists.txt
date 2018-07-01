#Cmake最低版本要求
cmake_minimum_required(VERSION 3.5)

#项目名称
#project(gcc64make C CXX)  自动判断不需要加这个
project(gcc64make)

#set(GCC64MAKE_VERSION_MAJOR 0)
#set(GCC64MAKE_VERSION_MINOR 8)
#set(GCC64MAKE_VERSION_PATCH 2)
#set(GCC64MAKE_VERSION
#    "${GCC64MAKE_VERSION_MAJOR}.${GCC64MAKE_VERSION_MINOR}.${GCC64MAKE_VERSION_PATCH}")

#允许gdb调试
#set(CMAKE_BUILD_TYPE "RELEASE")   ## 如果要cmake 带参的话, 这个不能设置, 默认是release
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall -DNDEBUG")
#C编译器的默认选项release加了-DNDEBUG ,C++编译器默认的release没有加-DNDEBUG, 所以assert在c++的release版本中依然生效. 这里要加上-DNDEBUG
#在编译的时候，使用如下命令 path是顶层目录 如 ..
#cmake -DCMAKE_BUILD_TYPE=Debug/Release  path

## 编译32位/64位
if(USE_32BITS)
 message(STATUS "using 32bits")
 set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32") 
 set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32") 
else()
endif(USE_32BITS)
#在编译的时候，使用如下命令 path是顶层目录 如 .. 
#cmake -DUSE_32BITS=1  path
#注意64系统要编译32的，需要先安装依赖 apt-get install libc6-dev-i386
#编译32位的c++ 时libstdc++库需要做软连接 cd /usr/lib32 && ln -s libstdc++.so.6 libstdc++.so

#添加C++11支持及其他选项
#set(CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS} -g -ftest-coverage -fprofile-arcs -Wno-deprecated")
#set(CMAKE_CXX_FLAGS "-std=c++0x ${CMAKE_CXX_FLAGS -g -ftest-coverage -fprofile-arcs"})

#当前目录下所有源文件赋给DIR_SRCS
aux_source_directory(. DIR_SRCS) 
#aux_source_directory(gcc64_make.c DIR_SRCS) 

##添加头文件
include_directories(./ ./hello ./world)
#相当于g++选项中的-I参数的作用，也相当于环境变量中增加路径到CPLUS_INCLUDE_PATH变量的作用

#添加子目录
add_subdirectory(hello) 
add_subdirectory(world)

#添加需要链接的库文件目录
#link_directories("/home/development/lib")
#相当于g++命令的-L选项的作用，也相当于环境变量中增加LD_LIBRARY_PATH的路径的作用

#添加需要链接的库文件路径
#lib名 全路径都行，下面都是正确的, 空格添加多个
#link_libraries(comm)
#link_libraries(-lcomm)
#link_libraries("/home/development/lib/libcomm.so")
#link_libraries(libcomm.a)  #显式指定静态链接库
#link_libraries(libcomm.so) #显式指定动态链接库

#生成可执行文件
add_executable(gcc64make ${DIR_SRCS}) 

#设置要链接的库文件的名称
#第三方库 libmcoomt.so 写做: mcoomt
#target_link_libraries(gcc64make hello world mcoomt)
#同样可以是名称或全路径等
target_link_libraries(gcc64make hello world)


## hello 文件夹 
## CMakeLists.txt
#aux_source_directory(. DIR_HELLO_SRCS)
#生成动态链接库 加 SHARED 生成后缀 .so  windows 上是.dll
#add_library(hello SHARED ${DIR_HELLO_SRCS})

## world 文件夹
## CMakeLists.txt
#aux_source_directory(. DIR_WORLD_SRCS)
#默认生成静态链接库 可以不加STATIC 生成后缀 .a
#add_library(world ${DIR_WORLD_SRCS})
#add_library(world STATIC ${DIR_WORLD_SRCS})