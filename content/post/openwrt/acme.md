---
title: "[openwrt] acme(自动生成ssl证书)"
description: openwrt-acme
keywords: "openwrt,acme"

date: 2023-08-07T12:30:58+08:00
lastmod: 2023-08-08T21:13:41+08:00

categories:
  - openwrt
tags: 
  - acme
---
## 所需条件&须知
  - 域名,已配置解析记录至公网ip
  - 授权阿里云AliyunDNSFullAccess权限策略至子用户
  - dns_api支持列表: https://github.com/acmesh-official/acme.sh/wiki/dnsapi
  - 保存后查看系统日志或进入/etc/acme/<域名>下查看是否生成<域名>.cer(可能需要等一段时间)
## 基于Ali DNS API
  1. 添加 -> 常规设置 -> 域名对应阿里云解析记录
  ![](wx_20230806224839.png)
  2. 质询验证
  ![](wx_20230806225224.png)

## 基于Cloudflare DNS API
  1. https://www.cloudflare.com/ -> 网站 -> <选择要使用的域名>
  2. 配置解析记录
  ![](wx_20230806230454.png)
  3. 添加实例 -> 常规设置 -> 域名对应Cloudflare解析记录
  4. 质询验证
    - 验证方式: DNS
    - DNS API: dns_cf
    - DNS API 凭证: CF_Key="", CF_Email=""