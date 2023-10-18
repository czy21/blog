---
title: "Linux 命令大全"
description: command
keywords: "linux"

date: 2023-10-17T10:20:58+08:00
lastmod: 2023-10-18T10:20:58+08:00

categories:
  - linux
tags: 
  - linux
---

- 系统: [用户](#用户) [权限](#权限) [文件](#文件) [磁盘](#磁盘) [系统](#系统)
- 服务: [ssh](#ssh) [docker](#docker)
- 其他: [mac](#mac)
------------
# 用户
```bash
useradd -d /home/[user] -m [user]   # 添加用户,并创建用户目录
adduser [user]                      # 添加用户
userdel -r [user]                   # 删除用户
usermod -G [group] [user]           # 把用户从其他组中去掉，只属于该组
usermod -a -G [group] [user]        #把用户添加至该组，之前所属组不影响
```
# 权限
```bash
# root用户下打开 /etc/sudoers 文件
# [user]   ALL=NOPASSWD: ALL 某用户不需要密码可以执行sudo
# %[group] ALL=NOPASSWD: ALL 某组的所有用户不需要密码可执行sudo
# 
# -rw------- (600) 只有拥有者有读写权限
# -rw-r--r-- (644) 只有拥有者有读写权限；而属组用户和其他用户只有读权限
# -rwx------ (700) 只有拥有者有读、写、执行权限
# -rwxr-xr-x (755) 拥有者有读、写、执行权限；而属组用户和其他用户只有读、执行权限
# -rwx--x--x (711) 拥有者有读、写、执行权限；而属组用户和其他用户只有执行权限
# -rw-rw-rw- (666) 所有用户都有文件读、写权限
# -rwxrwxrwx (777) 所有用户都有读、写、执行权限
chown -R [user]:[group] [filePath]    # 更改文件拥有者及组
```
# 文件
```bash
tar --exclude=*.mp3 -zcvf file.tar.gz [filePath]          # 过滤文件并压缩
tar -xzvf file.tar.gz -C [targetPath]                     # 解压缩至指定目录
ls -lR|grep "^-"|wc -l                                    # 统计当前文件夹下文件的个数，包括子文件夹
ls -lR|grep "^d"|wc -l                                    # 统计当前文件夹下目录的个数，包括子文件夹
ls -l |grep "^-"|wc -l                                    # 统计当前文件夹下文件的个数
ls -l |grep "^d"|wc -l                                    # 统计当前文件夹下目录的个数
ls -1 *.ts | sort -n | xargs cat > merged.ts              # 按顺序合并文件到merged.ts
find . -type d -empty -delete                             # 删除空目录
find -type d -empty | xargs rmdir -p                      # 删除当前目录下所有空文件夹
find . -type f | grep '\./\.' | xargs rm -rf.             # 删除以 ./.开头的文件
find temp/*201902* -not -name *20190214* | xargs rm -rf   # 删除除某种条件下的文件
find . -type f -name *-compose.yml -exec sed -i -e '/./,$!d' -e :a -e '/^\n*$/{$d;N;ba' -e '}' {} \;  # 去除开始与结尾空行 保留中间部分
find . -type f -name *-compose.yml -exec sed -i -e '$a\[plantext]' {} \;                # 文本末尾批量追加
find . -type f -name 'init_config.sh' -exec sh -c 'f={};mv $f $(dirname $f)/init.sh' \; # 批量修改文件
find . -name "[file]" -exec grep -l '[hello]' {} \; | xargs rm -rf                      # 过滤文件+过滤内容+删除
find . -name "-*" -exec sh -c 'f={}; mv $f $(echo $f | sed 's/-//g')' \;                # 正则修改文件名称
find . -type f -name values.yaml -size 0c -exec rm -rf {} \;                            # 批量删除空文件
find . -type f -exec sh -c 'f={};if echo $f | grep -q src ; then sed -i "s|com.learning|com.czy.learning|g" $f; fi;' \; # 修改匹配路径下的文件内容
find . -maxdepth 1 -type f -exec md5sum {} \; | sort | uniq -D -w 33   # md5 文件查重
find -name '*.gradle' -exec sed -i -e 's|compile|implementation|g' -e 's|testCompile|testImplementation|g' -e 's|runtime|implementation|g' {} \;
sed -i '1,nd' [file] # 删除前n行
sed -i -e 's/^INSERT INTO public\./INSERT INTO /' [file] # 正则替换
cat nginx.conf | grep -oP 'upstream \K\w.*?(?={)' | awk '{printf $1 ";"}'  # 正则提取upsteam地址
# \$\{(\S+?)\}   -------->   \${\L$1}    # 正则匹配括号内内容 并转为大小写(idea)
```
# 磁盘
```bash
du -hd0 .         # 查看当前目录下总空间大小
du -hd1           # 查看当前目录及各目录的总空间大小

fdisk /dev/sdb                n  初始化分区
mkfs.ext4 /dev/sdb1              格式化系统
```
# Mount
  + Disk
    ```bash
    # get device name
    fdisk -l
    # get device uuid
    blkid /dev/sdb1
    # disk in /etc/fstab
    /dev/disk/by-uuid/<uuid> /volume1 ext4 defaults 0 0
    ```
  + NFS
    ```bash
    # show nfs
    showmount -e [host]
    # nfs in /etc/fstab
    [host]:/volume1/ubuntu /volume1 nfs defaults 0 0
    
    # nfs command line
    sudo mount -t nfs <nfs_server>:/<nfs_path> /<local_path>
    ```
  + SMB
    ```bash
    # smb in /etc/fstab
    //<host>/public/ubun12   /volume2   cifs   user=<username>,pass=<password>,gid=1000,uid=1000    0 0
    
    # smb command line
    sudo mount -t cifs //<smb_server>/<smb_path> /<local_path> -o "user=<username>,password=<password>,gid=1000,uid=1000"
    ```
# 系统
```bash
# set hostname
hostnamectl set-hostname --static [hostname]
```
# ssh
```bash
scp -r [user]@[host]:/home/[user]/*[!.mp3] d:/upload/      # 从服务器下载文件
scp -r [local] [user]@[host]:[remote]                      # 本地上传文件至服务器
ssh [user]@[host] 'bash -s' < test.sh init                 # ssh运行加参数的本地脚本
ssh [user]@[host] < test.sh                                # ssh直接运行.sh脚本
ssh [user]@[host] 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub # 将本地公钥id_rsa.pub传给远程主机
```
# rsync
```shell
# list remote module
rsync rsync://<host>
# -e "ssh -i <private_key_file>"
# push
rsync --progress -avogXH <local_path> rsync://<user>@<host>:<remote_path>
# pull
rsync --progress -avogXH rsync://<user>@<host>:<remote_path> <local_path>
```
# docker
```bash
docker pull mysql:5.7
docker run --name mysql -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 -d mysql:5.7
docker exec -it pwc-mysql /usr/bin/bash (win10下 前面加上 wintpy)

docker stop $(docker ps -a -q)                                       # 停止容器
docker rm $(docker ps -a -q)                                         # 删除容器
docker image rm $(docker image ls -a -q)                             # 删除镜像
docker volume rm $(docker volume ls -q)                              # 删除数据卷
docker network rm $(docker network ls -q)                            # 删除 network
docker rm $(docker ps -q -f status=exited)                           # 删除 exited 容器
docker restart $(docker ps -aq --filter 'exited=0')                  # 重启 exited 容器
docker stop $(docker ps -a -q) && docker system prune --all --force  # 全部清理
docker rm -f $(docker ps -a -q) && docker volume prune -y            # 清空所有容器及数据卷
docker rm $(docker ps -qa --no-trunc --filter "status=exited")       # 清空exited的容器
docker image prune -a                                                # 清空未使用的镜像
docker ps -a --filter volume=                                        # 根据volume name获取container
```
# mac
```bash
# homebrew
export ALL_PROXY=socks5://127.0.0.1:1080
# mongo
brew install libpq
# mysql
brew install mysql-client
```