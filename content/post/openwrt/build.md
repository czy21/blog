---
title: "OpenWRT 官方系统构建"
description: "build"
keywords: "build"

date: 2023-08-08T14:36:15+08:00
lastmod: 2023-08-08T15:35:35+08:00

categories:
  - openwrt
tags:
  - build
  -
---
## 基于ubuntu 22.04
## 注意
- 使用非root用户进行编译
- 默认登录192.168.1.1 无密码
- esxi中安装,非正常关闭系统(断电)可能会导致openwrt无法启动
- Base system -> dnsmasq和dnsmasq-full只能二选一
## 安装依赖
```shell
sudo apt update -y
sudo apt install -y build-essential clang flex g++ gawk gcc-multilib gettext git libncurses5-dev libssl-dev python3-distutils rsync unzip zlib1g-dev file wget qemu-utils libelf-dev vim git make gcc
```
## 首次构建
```shell
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
git checkout v22.03.5
echo "
src-git helloworld https://github.com/fw876/helloworld
src-git openclash https://github.com/vernesong/OpenClash
src-git plugin https://github.com/czy21/openwrt-plugin.git
" >> feeds.conf.default
./scripts/feeds update -a && ./scripts/feeds install -a
make menuconfig
nohup make -j1 V=s & # 首次构建推荐使用单线程
tail -f nohup.out
```
## 二次构建
```shell
git pull
./scripts/feeds update -a && ./scripts/feeds install -a
make menuconfig
nohup make -j$(($(nproc) + 1)) V=s &
tail -f nohup.out
```
## 重新构建
```shell
rm -rf .tmp .config
make menuconfig
nohup make -j$(($(nproc) + 1)) V=s &
tail -f nohup.out
```
----
## 其他
```shell
# 更新并安装feeds.conf.default中指定依赖
pkg=plugin && ./scripts/feeds update ${pkg} && ./scripts/feeds install -a -p ${pkg}
```
