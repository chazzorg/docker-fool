# docker-fool


## 目录介绍

```
.
├── bin                                 # 核心逻辑处理
├── composes                            # docker-compose存放目录
│    ├── common                         # 服务对应目录
│    └── base.yml                       # 公共头部文件
├── dockerfile                          # 服务镜像构建目录
├── runtime                             # 运行数据日志存放目录
├── www                                 # 代码存放目录
├── .env.example                        # .env 示例文件
└── fool                                # 执行使用脚本

```

## 项目介绍

docker-fool  `傻瓜式`操作,努力简化使用docker搭建应用环境过程。
它包含预包装 Docker 镜像，可以快速为你搭建 PHP, NGINX, MySQL 等服务，所有镜像均已官方镜像为基础，可根据需要自由选择或替换某项服务，简单、透明、方便、快速。



#### 项目地址 ：[码云](https://gitee.com/chazzorg/docker-fool)      [github](https://github.com/chazzorg/docker-fool)

**使用概览：**

让我们了解使用它安装 `NGINX`, `PHP`, `MySQL` 和 `Redis`

1. 将本项目复制到任意位置，进入项目根目录，使用前请确认 docker docker-compose 命令可用
```bash
cd docker-fool
```

2. 运行根目录下脚本文件
 ```bash
./fool
```

3. 根据脚本引导，选择对应操作

4. 容器关闭之后快速启动，可在根目录下执行`./start` 或 `docker-compose up -d`


### 特点

- 在 PHP 版本：7.0，5.6.5.5...之中可以简单切换。
- 所有软件运行在不同的容器之中，比如：PHP-FPM, NGINX, PHP-CLI...
- 通过简单的编写 `Dockerfile` 容易定制任何容器。
- 所有镜像继承自一个官方基础镜像（Trusted base Images）
- 容易应用容器中的配置 配置文件（`Dockerfile`）
- 所有的都是可视化和可编辑的
- 快速的镜像构建

### docker 使用常用命令



**例子:** 运行容器*(在运行 `docker-compose` 命令之前，确认你在项目目录中）*

```bash
docker-compose up -d  nginx mysql
```
你可以从以下列表选择你自己的容器组合：

`nginx`, `php-fpm`, `php-worker`, `mysql`, `redis`, `apache`

**例子:** 进入容器

```bash
docker-compose exec nginx bash
```

**例子:** 列出正在运行的容器
```bash
docker ps
```

你也可以使用以下命令查看所有容器
```bash
dockere ps -a
```

**例子:** 查看容器中运行的进程信息，支持 ps 命令参数
```bash 
docker top {容器名称/容器ID} -aux|grep {进程关键字} | wc -l
```

**例子:** 开启指定容器
```bash
docker start {容器名称/容器ID}
```

**例子:** 重启指定容器
```bash
docker restart {容器名称/容器ID}
```

**例子:** 关闭指定容器 
```bash
docker stop {容器名称/容器ID}
```

**例子:** 开启某个服务:

```bash
docker-compose start {服务名称}
```

**例子:** 重启某个服务:

```bash
docker-compose restart {服务名称}
```

**例子:** 停止某个服务:

```bash
docker-compose stop {服务名称}
```

**例子:** 删除所有容器
```bash
docker-compose down
```
### 自定义独立队列容器【php-worker】

1 - 打开 `.env` 文件, 设置 php-worker 相关参数，确认所需要的扩展

2 - 在 services/php-worker/supervisord.d目录下，创建队列运行配置文件

3 - 启动容器 `docker-compose up -d php-worker`



### 编辑 Docker 镜像

1 - 找到你想修改的镜像的 `Dockerfile` 

例如： `mysql` 在 `mysql/Dockerfile`.

2 - 按你所要的编辑文件.

3 - 重新构建容器:

```bash
docker-compose build mysql
```

### 建立/重建容器

如果你做任何改变 `Dockerfile` 确保你运行这个命令,可以让所有修改更改生效:

```bash
docker-compose build
```

选择你可以指定哪个容器重建(而不是重建所有的容器):

```bash
docker-compose build {服务名称}
```

### 自定义目录

如果你想自由设置工作目录，你需要编辑项目下 `.env` 文件中目录的设置，更改之后重新运行 `docker-compose up -d`
