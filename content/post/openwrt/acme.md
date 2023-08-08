---
title: "[openwrt] acme"
description: openwrt-acme
keywords: "openwrt,acme"

date: 2023-08-07T12:30:58+08:00
lastmod: 2023-08-07T12:30:58+08:00

categories:
  - openwrt

tags: 
  - 
---
## 基于Ali DNS API
-  所需条件
  - 域名,已配置解析记录至公网ip
  - 拥有阿里云AliyunDNSFullAccess权限策略的子用户或主用户(推荐使用子用户)
1. 添加 -> 常规设置 -> 域名对应阿里云解析记录
![](wx_20230806224839.png)
1. 质询验证; dns_api支持列表: https://github.com/acmesh-official/acme.sh/wiki/dnsapi
![](wx_20230806225224.png)
1. 保存 -> 查看系统日志或进入/etc/acme/<域名>下查看是否生成<域名>.cer(可能需要等一端时间)

## 基于CloudFlare DNS API
- 所需条件
  - 域名,已配置解析记录至公网ip
  - 拥有阿里云AliyunDNSFullAccess权限策略的子用户或主用户(推荐使用子用户)
1. 网站 -> <选择要使用的域名>
2. 配置解析记录
![](wx_20230806230454.png)
1. 添加实例 -> 常规设置 -> 域名对应阿里云解析记录
![](wx_20230806224839.png)
1. 质询验证; dns_api支持列表: https://github.com/acmesh-official/acme.sh/wiki/dnsapi
![](wx_20230806225224.png)
1. 保存 -> 查看系统日志或进入/etc/acme/<域名>下查看是否生成<域名>.cer(可能需要等一端时间)