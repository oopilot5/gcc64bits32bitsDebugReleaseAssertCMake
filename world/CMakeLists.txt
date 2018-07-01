
aux_source_directory(. DIR_WORLD_SRCS)
#默认生成静态链接库 可以不加STATIC 生成后缀 .a
#add_library(world ${DIR_WORLD_SRCS})
add_library(world STATIC ${DIR_WORLD_SRCS})