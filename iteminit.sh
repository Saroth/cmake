#!/bin/sh
# 初始化工程项目，自动创建输出目录并执行cmake
# Usage:
#       $ ./iteminit.sh <item>

# 显示帮助说明
function print_help {
    echo -e "Usage: $ ./iteminit.sh <item>"
    echo -e "Avaliable items:"
    for item in ${items}; do
        echo -e "\t> "${item}
    done
    exit
}
# 初始化
function init_item_dir {
    curpath=$(cd $(dirname $1); pwd)
    objpath=${curpath}/../${2}
    if [ ! -d ${objpath} ]; then
        echo mkdir: ${objpath}
        mkdir ${objpath}
    fi
    cd ${objpath}
    cmake -DITEM=${2} ${curpath}
    exit
}

# 搜索CmakeLists.txt中的项目
items=$(
sed -n 's/^macro([ ]*\(.*\) .*).*$/\1/p' ./CMakeLists.txt |
grep -v item_list
)
if [ ! $# -eq 1 ]; then
    echo -e "Param error!"
    print_help
fi
for item in ${items}; do
    if [[ $1 == ${item} ]]; then
        init_item_dir $0 $1
    fi
done
echo -e "No such item: $1"
print_help

