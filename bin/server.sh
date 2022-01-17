#!/bin/bash

# 显示可安装服务
function showServer(){
    for file in ./composes/common/*.yml
    do
        temp_file=`basename $file .yml`
        echo $temp_file
    done
}

# 启动服务
function startServer(){
    if [ -f "start" ];  then
        chmod 700 ./start
        ./start
        echo '***************************'
        echo " "
        echo -e "\033[32m 服务启动成功 \033[0m"
        echo '***************************'
        echo " "
    else
        echo -e "\033[31m !!!!!!!!! 服务启动失败!!!!!!!!! \033[0m"
    fi
}

# 创建服务
function initServer(){
    if [ -f "docker-compose.yml" ];  then
        rm -rf docker-compose.yml
    fi
    cp ./composes/base.yml ./docker-compose.yml
    serverList=(${1})
    for serverName in ${serverList[@]}
    do
        if [ -f ./composes/common/${serverName}".yml" ];  then
            echo >> docker-compose.yml
            cat ./composes/common/${serverName}".yml" >> docker-compose.yml
            echo >> docker-compose.yml
            createDir ${1}
        fi
    done
}

# 服务安装锁定
function initLock(){
    if [ -f "start" ];  then
        rm -rf start
    fi
    touch start
    echo "#!/bin/bash" >> start
    echo "docker-compose up -d $1" >> start
}

# 追加服务
function appendServer(){
    if [ ! -f "docker-compose.yml" ];  then
        cp ./composes/base.yml ./docker-compose.yml
    fi
    if [ -f ./composes/common/${1}".yml" ];  then
        echo >> docker-compose.yml
        cat ./composes/common/${1}".yml" >> docker-compose.yml
        echo >> docker-compose.yml
        createDir ${1}
    else
        echo -e "\033[31m !!!!!!!!! 服务未配置 !!!!!!!!! \033[0m"
    fi
}

# 启动脚本追加服务
function appendLock(){
    if [ ! -f "start" ];  then
        touch start
        echo "#!/bin/bash" >> start
        echo "docker-compose up -d " >> start
    fi
    sed -i 's/docker.*/& '${1}'/g' start
}

# 相关文件夹创建
function createDir(){
    getName=${1^^}
    logName=($(eval echo '${'"$getName"'_LOG}'))
    if test -n "$logName"; then
        if [ ! -d ${RUNTIME_PATH_HOST}${logName} ];then
            mkdir -p ${RUNTIME_PATH_HOST}${logName}
        fi
    fi
    dataName=($(eval echo '${'"$getName"'_DATA}'))
    if test -n "$dataName"; then
        if [ ! -d ${RUNTIME_PATH_HOST}${dataName} ];then
            mkdir -p ${RUNTIME_PATH_HOST}${dataName}
        fi
    fi
}

# 快速创建服务
function runAll(){
    checkEnv
    if [ $? == 12 ];  then
        echo -e "\033[31m !!!!!!!!! 环境变量文件不存在 !!!!!!!!! \033[0m"
        exit
    fi
    echo " "
    echo '******  可安装服务列表： ******:'
    showServer
    echo '***************************'
    echo -e "可自由组合服务安装： \c"
    read aReserver
    source ./.env
    initServer "${aReserver[*]}"
    initLock "${aReserver[*]}"
    startServer
}

# 快速添加服务
function runOne(){
    checkEnv
    if [ $? == 12 ];  then
        echo -e "\033[31m !!!!!!!!! 未创建环境变量文件!!!!!!!!! \033[0m"
        exit
    fi
    echo " "
    echo '***************************'
    echo " "
    echo -e "已创建服务： \c"
    if [ -f "start" ];  then
        content=`sed -n "2 p" start`
        echo -e "\033[31m ${content:21} \033[0m"
    fi
    echo " "
    echo '******  可选择单个服务,不可重复添加： ******:'
        showServer
    echo '***************************'
    echo -e "请选择服务： \c"
    read aReserver
    source ./.env
    checkLock "${aReserver[*]}"
    if [ $? == 12 ];  then
        echo -e "\033[31m !!!!!!!!! 重复添加 !!!!!!!!! \033[0m"
        exit
    fi
    appendServer "${aReserver[*]}"
    appendLock "${aReserver[*]}"
    startServer
}