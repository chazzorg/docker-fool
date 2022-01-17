#!/bin/bash

# 设置上海时区
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Start crond in background
crond -l 2 -b

# Start nginx in foreground
nginx
