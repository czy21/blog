---
title: "OpenWRT WireGuard 异地组网"
description: "openwrt-wireguard"
keywords: "openwrt,wireguard"

date: 2024-03-31T12:31:13+08:00
lastmod: 2024-03-31T12:31:13+08:00

categories:
  - openwrt
tags:
  - wireguard
---

## 依赖
- luci-proto-wireguard 
- qrencode
## 新建接口: 网络 -> 接口 -> 添加新接口
![](add_interface.png)
## 常规设置
![](setting.png)
## 防火墙设为lan
## 对端 -> 添加对端
![](add_node.png)
## 生成对端配置
![](generate_node.png)

## 注
- xxx.com为本端域名或公网ip地址
- 添加对端时允许的ip不能填本路由所属的ip段,否则会导致无法访问本路由