#!/bin/sh
# 清除所有传入的路径下，CMake生成的除Makefile外的文件
# Usage:
#       $ ./clean.sh <path> [path] [...]

if [[ $1 == "-h" || $1 == "--help" ]]
then
    echo -e "Usage: $ ./clean.sh <dir1> [<dir2> [...]]"
    exit
fi

curpath=$(cd $(dirname $0); pwd)
for dir in $@
do
    cd ${curpath}/${dir}
    if [ -d ${curpath}/${dir} ]
    then
        rm CMakeCache.txt
        rm cmake_install.cmake
        rm -r CMakeFiles
    fi
done

