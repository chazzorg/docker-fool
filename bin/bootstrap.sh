#!/bin/bash

# 加载核心文件
source ./bin/check.sh
source ./bin/install.sh
source ./bin/setting.sh
source ./bin/server.sh
source ./bin/site.sh

# 检查软件安装
# checkRun

# 命令入口
function RunFool(){
    case $1 in
        1)
            runSetting
        ;;
        2)
            runAll
        ;;
        3)
            runOne
        ;;
        4)
            runSite
        ;;
        *)
            echo '功能暂未开发' 
        ;;
    esac
} 