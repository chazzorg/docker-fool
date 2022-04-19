ARG GO_VERSION
FROM golang:${GO_VERSION}

LABEL maintainer="chazz"

ARG CHANGE_SOURCE=false
RUN if [ ${CHANGE_SOURCE} = true ]; then \
    # Change application source from deb.debian.org to aliyun source
    sed -i 's/deb.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list && \
    sed -i 's/security-cdn.debian.org/mirrors.aliyun.com/' /etc/apt/sources.list \
;fi

RUN apt-get update && apt-get install -y vim


RUN mkdir -p /go/src && mkdir -p /go/pkg && mkdir -p /go/bin

## 设置工作目录
WORKDIR /go/src

## 设置docker要开发的哪个端口
EXPOSE 8080