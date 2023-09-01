---
title: "OpenWRT 官方系统构建"
description: "build"
keywords: "build"

date: 2023-08-08T14:36:15+08:00
lastmod: 2023-08-21T09:26:35+08:00

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
sed -i -e 's|\^.*|;openwrt-22.03|' feeds.conf.default
echo "
src-git helloworld https://github.com/fw876/helloworld
src-git plugin https://github.com/czy21/openwrt-plugin.git
" >> feeds.conf.default
./scripts/feeds update -a && ./scripts/feeds install -a && ./feeds/plugin/sync.sh
make menuconfig
nohup make -j1 V=s & # 首次构建推荐使用单线程
tail -f nohup.out
```
## 二次构建
```shell
git pull
./scripts/feeds update -a && ./scripts/feeds install -a && ./feeds/plugin/sync.sh
make menuconfig
nohup make -j$(nproc) V=s &
tail -f nohup.out
```
## 重新构建
```shell
rm -rf tmp .config
make menuconfig
nohup make -j$(nproc) V=s &
tail -f nohup.out
```
----
## 其他
```shell
# 更新并安装feeds.conf.default中指定依赖
pkg=plugin && ./scripts/feeds update ${pkg} && ./scripts/feeds install -a -p ${pkg}
# Raspberry pi zero w
Target System: Broadcom BCM27xx
Target Images 
  Root filesystem partition size
Kernel modules > USB Support:
  kmod-usb-dwc2
  kmod-usb-net-cdc-ether
```
## 应用描述
  * luci-app-dawn           # 分布式AP管理程序
  * luci-app-diag-core      # core诊断工具
  * luci-app-minidlna       # 多媒体共享
  * luci-app-mjpg-streamer  # 摄像头采集
  * luci-app-mosquitto      # MQTT 消息队列
  * luci-app-mwan3          # 多播负载均衡
  * luci-app-nlbwmon        # 网络带宽监视器
  * luci-app-nut            # ups 管理
  * luci-app-ocserv         # OpenConnect VPN服务
  * luci-app-openwisp       # AP管理
  * luci-app-opkg           # openwrt 包管理
  * luci-app-radicale2      # 日历 联系人同步
  * luci-app-ksmbd          # smb server
  * luci-app-nfs            # nfs server
## 常见问题
 * cron.err xxxxxx 意为cron执行过任务,不是任务内部出错