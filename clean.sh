#!/bin/sh
# 清除所有传入的路径下，CMake生成的文件
# Usage:
#       $ ./clean.sh <path> [path] [...]

curpath=$(cd $(dirname $0); pwd)
for dir in $@
do
    cd ${curpath}/${dir}
    if [ -d ${curpath}/${dir} ]
    then
        rm CMakeCache.txt
        rm cmake_install.cmake
        rm Makefile
        rm -r CMakeFiles
    fi
done

