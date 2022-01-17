#!/bin/bash

# 添加 nginx 站点
function addNginx(){
    echo '***************************'
    echo -e "填写网站域名(a.com)： \c"
    read setSiteName
    echo '***************************'
    echo -e "填写网站目录： \c"
    read setWwwRoot
    echo '****** 可选择配置模板 ******:'
    source ./.env
    for file in ${DOCKERFILE_PATH_HOST}/nginx/site-example/*.example
    do
        temp_file=`basename $file .example`
        echo $temp_file
    done
    echo '***************************'
    echo -e "输入模板： \c"
    read setFrame
    if [ -n "$setSiteName" ];
    then
        if [ -f ${DOCKERFILE_PATH_HOST}/nginx/site-example/${setFrame}.example ];  then
            cp ${DOCKERFILE_PATH_HOST}/nginx/site-example/${setFrame}.example ${DOCKERFILE_PATH_HOST}/nginx/sites/${setSiteName}.conf
            sed -i 's/app.site/'${setSiteName}'/g' ${DOCKERFILE_PATH_HOST}/nginx/sites/${setSiteName}.conf
            sed -i 's/app.root/'${setWwwRoot}'/g' ${DOCKERFILE_PATH_HOST}/nginx/sites/${setSiteName}.conf
            docker restart $(basename "$PWD")"_nginx_1"
        fi
    fi
    echo " "
    echo -e "\033[32m 站点添加成功 \033[0m"
}

# 添加 apache 站点
function addApache(){
    echo '***************************'
    echo -e "填写网站域名(a.com)： \c"
    read setSiteName
    echo '***************************'
    echo -e "填写网站目录： \c"
    read setWwwRoot
    echo '****** 可选择配置模板 ******:'
    source ./.env
    for file in ${DOCKERFILE_PATH_HOST}/apache/site-example/*.example
    do
        temp_file=`basename $file .example`
        echo $temp_file
    done
    echo '***************************'
    echo -e "输入模板： \c"
    read setFrame
    if [ -n "$setSiteName" ];
    then
        if [ -f ${DOCKERFILE_PATH_HOST}/apache/site-example/${setFrame}.example ];  then
            cp ${DOCKERFILE_PATH_HOST}/apache/site-example/${setFrame}.example ${DOCKERFILE_PATH_HOST}/apache/sites/${setSiteName}.conf
            sed -i 's/app.site/'${setSiteName}'/g' ${DOCKERFILE_PATH_HOST}/apache/sites/${setSiteName}.conf
            sed -i 's/app.root/'${setWwwRoot}'/g' ${DOCKERFILE_PATH_HOST}/apache/sites/${setSiteName}.conf
            docker restart $(basename "$PWD")"_apache_1"
        fi
    fi
    echo " "
    echo -e "\033[32m 站点添加成功 \033[0m"
}

function runSite(){
    echo '***************************'
    echo "nginx"
    echo "apache"
    echo '***************************'
    echo -e "请选择： \c"
    read aReSite
    case $aReSite in
        "nginx")
            addNginx
        ;;
        "apache")
            addApache
        ;;
        *)  
            echo '不支持该类型' 
        ;;
    esac
}