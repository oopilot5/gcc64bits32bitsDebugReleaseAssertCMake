
aux_source_directory(. DIR_HELLO_SRCS)
#生成动态链接库 加 SHARED 生成后缀 .so  windows 上是.dll
add_library(hello SHARED ${DIR_HELLO_SRCS})