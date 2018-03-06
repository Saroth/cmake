cmake_minimum_required(VERSION 2.6)             # 最低CMake版本

###############################################################################
#### Default configuration {                    #### 工程通用配置选项
set(name_project    "LIBTLS")                   # 工程名
set(name_target     "libtls.a")                 # 目标名

set(dir_sources     "${CMAKE_CURRENT_SOURCE_DIR}/../src/"
    "${CMAKE_CURRENT_SOURCE_DIR}/../openssl/"
    "${CMAKE_CURRENT_SOURCE_DIR}/../mbedtls/"
    )                                           # 源路径
set(dir_outputs     "${CMAKE_CURRENT_SOURCE_DIR}/../${ITEM}/") # 目标路径
set(dir_libraries   "${CMAKE_CURRENT_SOURCE_DIR}/../lib/") # 库路径
set(dir_includes    
    "${CMAKE_CURRENT_SOURCE_DIR}/../inc"
    "${CMAKE_CURRENT_SOURCE_DIR}/../src/openssl"
    )                                           # 包含路径

set(compiler_type   "arm-none-eabi-")           # 编译器类型，可为空
set(compiler_opts   "\
-Wall -Os \
-mabi=aapcs -mcpu=arm926ej-s -msoft-float \
-mthumb -mthumb-interwork \
-fdata-sections -ffunction-sections \
")                                              # 编译选项
set(compiler_defs   )                           # 宏
set(compiler_linker_flags )                     # 链接选项

set(source_types    "*.c" "*.cpp" "*.s")        # 源文件类型
set(source_libraries )                          # 库文件
set(source_filter   )                           # 源文件过滤，支持通配符

###############################################################################}
#### Items configuration {    #### 各项目配置选项，可对通用配置进行重定义或补充
macro(libmbedtls type)                         # 项目:MbedTLS库
    if(${type} STREQUAL "config")
        set(name_target "mbedtls")
        set(source_filter   ${source_filter}
            "../openssl/*"
            "../src/openssl/*"
            "../mbedtls/programs/*"
            "../mbedtls/tests/*"
            "../mbedtls/visualc/*"
            "../mbedtls/yotta/*"
            )
    elseif(${type} STREQUAL "target")
        add_library(${name_target} ${SRC_FILES})
    endif()
endmacro(libmbedtls)

macro(libopenssl_ssl type)                     # 项目:OpenSSL SSL库
    if(${type} STREQUAL "config")
        set(name_target "openssl_ssl")
        set(source_filter   ${source_filter}
            "../mbedtls/*"
            "../src/openssl/*"

            "../openssl/apps/*"
            "../openssl/bugs/*"
            "../openssl/demos/*"
            "../openssl/engines/*"
            "../openssl/MacOS/*"
            "../openssl/ms/*"
            "../openssl/test/*"
            "../openssl/crypto/*"

            "../openssl/ssl/clienthellotest.c"
            "../openssl/ssl/heartbeat_test.c"
            "../openssl/ssl/ssl_task.c"
            "../openssl/ssl/ssltest.c"
            "../openssl/ssl/sslv2conftest.c"
            )
    elseif(${type} STREQUAL "target")
        add_library(${name_target} ${SRC_FILES})
    endif()
endmacro(libopenssl_ssl)

macro(libopenssl_crypto type)                     # 项目:OpenSSL Crypto库
    if(${type} STREQUAL "config")
        set(name_target "openssl_crypto")
        set(source_filter   ${source_filter}
            "../mbedtls/*"

            "../openssl/apps/*"
            "../openssl/bugs/*"
            "../openssl/demos/*"
            "../openssl/engines/*"
            "../openssl/MacOS/*"
            "../openssl/ms/*"
            "../openssl/test/*"
            "../openssl/ssl/*"

            "../openssl/crypto/mdc2/*"
            "../openssl/crypto/threads/*"
            "../openssl/crypto/cast/*"
            "../openssl/crypto/perlasm/*"
            "../openssl/crypto/ripemd/*"
            "../openssl/crypto/jpake/*"
            "../openssl/crypto/whrlpool/*"
            "../openssl/crypto/dso/*"
            "../openssl/crypto/dsa/*"
            "../openssl/crypto/dh/*"
            "../openssl/crypto/rc5/*"
            "../openssl/crypto/rc4/*"
            "../openssl/crypto/rc2/*"
            "../openssl/crypto/engine/*"
            "../openssl/crypto/camellia/*"
            "../openssl/crypto/md4/*"
            "../openssl/crypto/md2/*"
            "../openssl/crypto/idea/*"
            "../openssl/crypto/srp/*"
            "../openssl/crypto/comp/*"
            "../openssl/crypto/bf/*"
            "../openssl/crypto/cms/*"
            "../openssl/crypto/des/*"
            "../openssl/crypto/seed/*"
            "../openssl/crypto/store/*"
            "../openssl/crypto/ui/*"
            "../openssl/crypto/txt_db/*"
            "../openssl/crypto/bn/asm/*"

            "../openssl/crypto/constant_time_test.c"
            "../openssl/crypto/uid.c"
            "../openssl/crypto/ia64cpuid.S"
            "../openssl/crypto/fips_ers.c"
            "../openssl/crypto/cpt_err.c"
            "../openssl/crypto/armv4cpuid.S"
            "../openssl/crypto/armcap.c"
            "../openssl/crypto/s390xcap.c"
            "../openssl/crypto/ppccap.c"
            "../openssl/crypto/o_dir_test.c"
            "../openssl/crypto/o_str.c"
            "../openssl/crypto/sparcv9cap.c"
            "../openssl/crypto/LPdir_wince.c"
            "../openssl/crypto/LPdir_win32.c"
            "../openssl/crypto/LPdir_win.c"
            "../openssl/crypto/LPdir_vms.c"
            "../openssl/crypto/LPdir_unix.c"
            "../openssl/crypto/LPdir_nyi.c"

            "../openssl/crypto/sha/sha1test.c"
            "../openssl/crypto/sha/shatest.c"
            "../openssl/crypto/bio/bss_rtcp.c"
            "../openssl/crypto/bio/bss_file.c"
            "../openssl/crypto/hmac/hmactest.c"
            "../openssl/crypto/md5/md5test.c"
            "../openssl/crypto/md5/md5s.cpp"
            "../openssl/crypto/rsa/rsa_test.c"
            "../openssl/crypto/bn/exp.c"
            "../openssl/crypto/bn/bnspeed.c"
            "../openssl/crypto/bn/exptest.c"
            "../openssl/crypto/bn/divtest.c"
            "../openssl/crypto/ec/ectest.c"
            "../openssl/crypto/ec/ecp_nistz256_table.c"
            "../openssl/crypto/ecdh/ecdhtest.c"
            "../openssl/crypto/err/err_all.c"
            "../openssl/crypto/evp/evp_key.c"
            "../openssl/crypto/evp/evp_test.c"
            "../openssl/crypto/evp/e_dsa.c"
            "../openssl/crypto/pkcs7/pk7_enc.c"
            "../openssl/crypto/pkcs7/bio_pk7.c"
            "../openssl/crypto/pqueue/pq_test.c"
            "../openssl/crypto/rand/randtest.c"
            "../openssl/crypto/rand/rand_nw.c"
            "../openssl/crypto/rand/rand_win.c"
            "../openssl/crypto/rand/rand_vms.c"
            "../openssl/crypto/rand/rand_unix.c"
            "../openssl/crypto/rand/rand_os2.c"
            "../openssl/crypto/rand/rand_egd.c"
            "../openssl/crypto/lhash/lh_test.c"
            "../openssl/crypto/conf/test.c"
            "../openssl/crypto/conf/cnf_save.c"
            "../openssl/crypto/x509v3/v3nametest.c"
            "../openssl/crypto/x509v3/v3conf.c"
            "../openssl/crypto/x509v3/v3prin.c"
            "../openssl/crypto/x509v3/tabtest.c"
            )
    elseif(${type} STREQUAL "target")
        add_library(${name_target} ${SRC_FILES})
    endif()
endmacro(libopenssl_crypto)

# 项目列表，根据配置参数ITEM选择: $ cmake -DITEM=x;
macro(item_list type)
    if(ITEM STREQUAL "build/libmbedtls")
        libmbedtls(${type})                    # 加载项目`libmbedtls`配置
    elseif(ITEM STREQUAL "build/libopenssl_ssl")
        libopenssl_ssl(${type})                # 加载项目`libopenssl_ssl`配置
    elseif(ITEM STREQUAL "build/libopenssl_crypto")
        libopenssl_crypto(${type})             # 加载项目`libopenssl_crypto`配置
    else()
        message(FATAL_ERROR "No such ITEM in `CMakeLists.txt`: ${ITEM}")
    endif()
endmacro(item_list)

###############################################################################}
#### [FIX] Utility Macro & Function {           #### 通用宏 & 通用函数
macro(load_compiler_config)                     # 加载编译器配置
    # 设置编译器类型或编译器选项后需要重新加载
    set(compiler_c      "${compiler_type}gcc")  # C编译器
    set(compiler_c_flags "${compiler_opts}")    # C编译选项
    set(compiler_cpp    "${compiler_type}g++")  # C++编译器
    set(compiler_cpp_flags "${compiler_opts}")  # C++编译选项
    set(compiler_asm    "${compiler_type}gcc")  # 汇编编译器
    set(compiler_asm_flags "${compiler_opts}")  # 汇编编译选项
    set(compiler_archive "${compiler_type}ar")  # 库编译器
    set(compiler_archive_flags "cvr")           # 库编译选项
    set(compiler_strip  "${compiler_type}strip") # 目标裁剪器
endmacro(load_compiler_config)

macro(set_compile_options)                      # 设置编译选项
    project(${name_project} CXX C ASM)          # 设置工程名和目标类型
    ## Compiler settings
    set(CMAKE_ASM_COMPILER ${compiler_asm})     # 设置汇编编译器
    SET(CMAKE_ASM_FLAGS ${compiler_asm_flags})  # 设置汇编编译选项
    set(CMAKE_C_COMPILER ${compiler_c})         # 设置C编译器
    set(CMAKE_C_FLAGS ${compiler_c_flags})      # 设置C编译选项
    set(CMAKE_CXX_COMPILER ${compiler_cpp})     # 设置C++编译器
    set(CMAKE_CXX_FLAGS ${compiler_cpp_flags})  # 设置C++编译选项
    set(CMAKE_EXE_LINKER_FLAGS ${compiler_linker_flags}) # 设置链接选项
    set(EXECUTABLE_OUTPUT_PATH ${dir_outputs})  # 设置目标输出目录
    set(LIBRARY_OUTPUT_PATH ${dir_outputs})     # 设置库输出目录
    ## Set no rdynamic link
    SET(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)      # 关闭动态链接
    SET(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS)    # 关闭动态链接
    # SET(CMAKE_VERBOSE_MAKEFILE on)              # 显示详细编译信息
    ## Load resources
    add_definitions(${compiler_defs})           # 加载宏
    include_directories(${dir_includes})        # 加载包含路径
    link_directories(${dir_libraries})          # 加载链接路径
    link_libraries(${source_libraries})         # 加载链接库
endmacro(set_compile_options)

macro(find_resource)                            # 获取源文件列表
    ## Types match                              # 获取各源目录下的搜索目标类型
    foreach(item ${source_types})
        foreach(dir ${dir_sources})
            list(APPEND MATCH_TYPES ${dir}${item})
        endforeach(dir)
    endforeach(item)
    ## File search                              # 根据搜索目标类型搜索所有源文件
    file(GLOB_RECURSE MATCH_FILES ${MATCH_TYPES})
    ## Source filter                            # 搜索过滤目标
    set(SRC_FILES ${MATCH_FILES})
    file(GLOB_RECURSE SRC_FILTER ${source_filter})
    if(SRC_FILTER)                              # 移除源文件中的过滤目标
        list(REMOVE_ITEM SRC_FILES ${SRC_FILTER})
    endif(SRC_FILTER)
endmacro(find_resource)

###############################################################################}
#### [FIX] Process {                            #### 配置处理流程
load_compiler_config()                          # 加载默认编译器配置
item_list("config")                             # 加载项目配置
set_compile_options()                           # 根据项目配置设置编译选项
find_resource()                                 # 根据项目配置加载源文件
item_list("target")                             # 加载项目编译目标配置

###############################################################################}
#### [FIX] Debug switchs {                      #### CMake配置调试控制
set(MSG_ALL 0)                                  # 总开关
set(MSG_BASE_INFO 1)                            # 基本信息
set(MSG_PROJECT_INFO 1)                         # 项目信息
set(MSG_COMPILE_INFO 1)                         # 编译器设置信息
set(MSG_MATCH_TYPES 0)                          # 匹配类型
set(MSG_MATCH_FILES 0)                          # 所有匹配文件列表
set(MSG_SRC_FILTER 1)                           # 过滤文件列表
set(MSG_SRC_FILES 1)                            # 所有源文件列表
set(MSG_TEST 0)                                 # 其他测试
#### Debug messages
if(MSG_ALL)
    message(STATUS "---------------- Debug info")
    # Base info {
    if(MSG_BASE_INFO)
        message(STATUS "#### Base informations:")
        message(STATUS "# System info:\t${CMAKE_SYSTEM}")
        message(STATUS "# System bit:\t${CMAKE_SIZEOF_VOID_P} * 8 bit")
        message(STATUS "# Current path:\t${CMAKE_CURRENT_LIST_DIR}")
    endif()
    # }
    # Project info {
    if(MSG_PROJECT_INFO)
        message(STATUS "#### Project settings:")
        message(STATUS "# Project name:\t${PROJECT_NAME}")
        message(STATUS "# Source dir:\t${dir_sources}")
        message(STATUS "# Bin output dir:\t${EXECUTABLE_OUTPUT_PATH}")
        message(STATUS "# Lib output dir:\t${LIBRARY_OUTPUT_PATH}")
        message(STATUS "# Source types:")
        foreach(item ${source_types})
            message(STATUS "#\t- ${item}")
        endforeach()
        message(STATUS "# Ignore list:")
        foreach(item ${source_filter})
            message(STATUS "#\t- ${item}")
        endforeach()
    endif()
    # }
    # Compiler settings {
    if(MSG_COMPILE_INFO)
        message(STATUS "#### Compile settings:")
        message(STATUS "# ASM compiler:\t${CMAKE_ASM_COMPILER}")
        message(STATUS "# ASM compiler opt:\t${CMAKE_ASM_FLAGS}")
        message(STATUS "# C compiler:\t${CMAKE_C_COMPILER}")
        message(STATUS "# C compiler opt:\t${CMAKE_C_FLAGS}")
        message(STATUS "# CXX compiler:\t${CMAKE_CXX_COMPILER}")
        message(STATUS "# CXX compiler opt:\t${CMAKE_CXX_FLAGS}")
        message(STATUS "# Linker opt:\t${CMAKE_EXE_LINKER_FLAGS}")
    endif()
    # }
    # File match types {
    if(MSG_MATCH_TYPES)
        message(STATUS "#### File match types:")
        foreach(item ${MATCH_TYPES})
            message(STATUS "#\t- ${item}")
        endforeach()
    endif()
    # }
    # All matched {
    if(MSG_MATCH_FILES)
        message(STATUS "#### All matched files:")
        foreach(srcfile ${MATCH_FILES})
            message(STATUS "#\t- ${srcfile}")
        endforeach()
    endif()
    # }
    # All filters {
    if(MSG_SRC_FILTER)
        message(STATUS "#### Filter objects:")
        foreach(filter_item ${SRC_FILTER})
            message(STATUS "#\t- ${filter_item}")
        endforeach()
    endif()
    # }
    # All sources {
    if(MSG_SRC_FILES)
        message(STATUS "#### Source files(filtered):")
        foreach(srcfile ${SRC_FILES})
            message(STATUS "#\t- ${srcfile}")
        endforeach()
    endif()
    # }
    # TEST {
    if(MSG_TEST)
        message(STATUS "---------------- Test")

    endif()
    # }
    message(STATUS "----------------")
endif()
###############################################################################}

