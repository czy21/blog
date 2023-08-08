---
title: "[openwrt] openvpn异地组网"
description: "openwrt-openvpn"
keywords: "openwrt,openvpn"

date: 2023-08-07T12:31:17+08:00
lastmod: 2023-08-08T06:32:51+08:00

categories:
  - openwrt
tags:
  - openvpn
  -
---

![](wx_20230806133350.png)
## 构建OpenWRT-22.03.5
* 官方仓库: https://github.com/openwrt/openwrt.git
* 插件地址: https://github.com/czy21/openwrt-plugin.git
*  Network > VPN
![](wx_20230806144011.png)
* LuCI -> Applications
![](wx_20230806144122.png)
## 服务端
1. 服务端需在公网下可访问,具体端口可自行指定
2. 配置OpenVPN服务端ovpn文件; server_01.ovpn
```text
dev tun
proto tcp
comp-lzo yes
persist-key
persist-tun
cipher AES-256-CBC
verb 3
keepalive 10 120
port 1198
server 10.8.100.0 255.255.255.0
topology subnet
duplicate-cn
auth-user-pass-verify "/etc/openvpn/auth.sh /etc/openvpn/server_01.auth" via-env
; 向客户端推送服务端所在内网的路由
push "route 192.168.2.0 255.255.255.0"
; 向客户端推送服务端的dns
push "dhcp-option DNS 192.168.2.2"
push "dhcp-option DNS 114.114.114.114"
log /var/log/openvpn.server_01.log
username-as-common-name
client-to-client
; 配置客户端ip,文件名为账号
client-config-dir /etc/openvpn/server_01_ccd
; 需要服务段内网访问客户端内网时需添加客户端内网路由
; route 192.168.5.0 255.255.255.0
<ca>
</ca>
<cert>
</cert>
<key>
</key>
<dh>
</dh>
```
3. 配置服务端账号的客户端ip文件;/etc/openvpn/server_01_ccd/test1
	```text
	ifconfig-push 10.8.100.3 255.255.255.0
	iroute 192.168.5.0 255.255.255.0
	```
4. 上传server_01.ovpn
![](wx_20230806145524.png)
5. 配置server_01.ovpn
![](wx_20230806144639.png)
6. 保存 -> start -> 查看系统日志或查看openvpn日志 /var/log/openvpn_**.log
