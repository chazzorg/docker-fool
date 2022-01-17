#!/bin/bash

################################## 环境判断 #############################

# Linux
function checkLinux(){
    sysname=`uname`
    if  [ $sysname = 'Linux' ]
    then
        return 0
    else
        return 12
    fi
}

# Cento
function checkCentos(){
    sysname=`cat /etc/redhat-release 2>&1 >/dev/null `
    if grep -q CentOS <<<$sysname; then
        return 0
    else
        return 12
    fi
}

# Windows
function checkWindows(){
    sysname=`uname`
    if grep -q MINGW64 <<<$sysname; then
        return 0
    else
        return 12 
    fi
}

# git
function checkGit(){
    syscmd=`git 2>&1 >/dev/null `
    if grep -q found <<<$syscmd; then
        return 12 
    else
        return 0
    fi
}

# docker
function checkDocker(){
    syscmd=`docker 2>&1 >/dev/null `
    if grep -q found <<<$syscmd; then
        return 12 
    else
        return 0
    fi
}

# docker-compose
function checkDockerCompose(){
    syscmd=`docker-compose 2>&1 >/dev/null `
    if grep -q found <<<$syscmd; then
        return 12 
    else
        return 0
    fi
}

# 安装锁定
function checkLock(){
    if [ -f "start" ];  then
        syscmd=`cat start `
        if grep -q $1 <<<$syscmd; then
            return 12 
        fi
    else
        return 0
    fi
}

# 环境变量文件
function checkEnv(){
    if [ ! -f ".env" ];  then
        return 12 
    else
        return 0
    fi
}

# 检测脚本入口
function checkRun(){
    checkGit
    if [ $? == 12 ];  then
        echo '***************************'
        echo " "
        echo -e "\033[31m !!!!!!!!! git 未安装 !!!!!!!!! \033[0m"
        echo " "
        echo '***************************'
    fi
    checkDocker
    if [ $? == 12 ];  then
        echo '***************************'
        echo " "
        echo -e "\033[31m !!!!!!!!! docker 未安装 !!!!!!!!! \033[0m"
        echo " "
        echo '***************************'
    fi
    checkDockerCompose
    if [ $? == 12 ];  then
        echo '***************************'
        echo " "
        echo -e "\033[31m !!!!!!!!! docker-compose 未安装 !!!!!!!!! \033[0m"
        echo " "
        echo '***************************'
    fi
}