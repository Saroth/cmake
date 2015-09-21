#!/bin/sh
# 初始化工程项目，自动创建输出目录并执行cmake
# Usage:
#       $ ./iteminit.sh <item>

if [ ! $# -eq 1 ]
then
    echo -e "Param error!"
    exit
fi
curpath=$(cd $(dirname $0); pwd)
objpath=${curpath}/../${1}
if [ ! -d ${objpath} ]
then
    echo mkdir: ${objpath}
    mkdir ${objpath}
fi
cd ${objpath}
cmake -DITEM=${1} ${curpath}

