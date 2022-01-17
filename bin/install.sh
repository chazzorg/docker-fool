#!/bin/bash

# 安装git
function installGit(){
    echo "####### 开始安装git #######"
    yum install -y git
    echo "####### git 安装完成 #######"
}

# 安装docker
function installDocker(){
    echo "####### 开始安装docker #######"
    # 安装docker需要的环境依赖
    yum install -y yum-utils device-mapper-persistent-data lvm2
    # 更换docker镜像源为阿里云镜像源
    yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    # 安装docker服务
    yum install -y docker-ce docker-ce-cli containerd.io
    echo "####### 启动 docker 服务 #######"
    # 启动docker服务
    systemctl start docker
    echo "####### 设置docker开机启动 #######"
    # 设置开机启动
    systemctl enable docker
    # 查看版本
    docker -v
    echo "####### docker 安装完成 #######"
}

# 安装docker-compose
function installDockerCompose(){
    echo "####### 开始安装 docker-compose #######"
    # 下载docker-compos
    curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    # 修改权限
    chmod +x /usr/local/bin/docker-compose
    # 注册命令
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    # 查看版本
    docker-compose --version
    echo "####### docker-compose 安装完成 #######"
}

# 安装脚本入口
function runInstall(){
    checkGit
    if [ $? == 12 ];  then
        installGit
    fi
    checkDocker
    if [ $? == 12 ];  then
        installDocker
    fi
    checkDockerCompose
    if [ $? == 12 ];  then
        installDockerCompose
    fi
}