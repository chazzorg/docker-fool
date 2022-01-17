#!/bin/bash

# 创建环境配置文件
function addEnv(){
    if [ ! -f ".env" ];  then
        cp .env.example .env
        echo '***************************'
        echo " "
        echo "配置文件创建成功：.env"
        echo " "
        echo '***************************'
    fi
}

# 创建Windows运行目录
function addWindowsWork(){
    if [ ! -d ${CODE_PATH_HOST} ];then
        mkdir ${CODE_PATH_HOST}
        echo '***************************'
        echo " "
        echo "代码存放目录："${CODE_PATH_HOST}
        echo " "
        echo '***************************'
    fi
    if [ ! -d ${RUNTIME_PATH_HOST} ];then
        mkdir ${RUNTIME_PATH_HOST}
        echo '***************************'
        echo " "
        echo "运行记录目录："${RUNTIME_PATH_HOST}
        echo " "
        echo '***************************'
    fi
}

# 创建Linux运行目录
function addLinuxWork(){
    if [ ! -d ${CODE_PATH_HOST} ];then
        mkdir ${CODE_PATH_HOST}
        chown -R www:www-data ${CODE_PATH_HOST}
        echo '***************************'
        echo " "
        echo "代码目录路径："${CODE_PATH_HOST}
        echo " "
        echo '***************************'
    fi
    if [ ! -d ${RUNTIME_PATH_HOST} ];then
        mkdir ${RUNTIME_PATH_HOST}
        echo '***************************'
        echo " "
        echo "运行记录目录："${RUNTIME_PATH_HOST}
        echo " "
        echo '***************************'
    fi
}

function runSetting(){
    addEnv
    source ./.env
    checkCentos
    if [ $? == 0 ];  then
        runInstall
    fi
    checkWindows
    if [ $? == 0 ];  then
        addWindowsWork
    fi
    checkLinux
    if [ $? == 0 ];  then
        addLinuxWork
    fi
}