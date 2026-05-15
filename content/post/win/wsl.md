---
title: "WSL环境配置"
description: wsl
keywords: "wsl"

date: 2026-05-15T13:50:38+08:00
lastmod: 2026-05-15T13:50:38+08:00

categories:
  - wsl
tags: 
  - wsl
---
## WSL安装
```powershell
# 以管理员身份运行PowerShell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
reboot

wsl --set-default-version 2

wsl --update

wsl --install Ubuntu-24.04
```

## Mirrored Network
1. Windows网卡设置的静态ip;只能保留一个,否则wsl中不能访问到局域网设备
2. 配置[当前Windows用户]/.wslconfig;注/etc/resolv.conf是否是Windows网卡的dns
    ```ini
    [wsl2]
    networkingMode=Mirrored
    dnsTunneling=false
    firewall=false
    ```
3. vim /etc/wsl.conf
    ```ini
    [boot]
    systemd=true

    [network]
    hostname=wsl

    [interop]
    enabled=false
    appendWindowsPath=false

    [automount]
    options = "metadata"
    ```
4. 重启wsl;wsl --shutdown

## Bridged Network
1. Hyper-V创建虚拟交换机;名称:vSwitch,连接类型:外部网络
2. 配置[当前Windows用户]/.wslconfig;注/etc/resolv.conf是否是Windows网卡的dns
    ```ini
    [wsl2]
    networkingMode=Bridged
    vmSwitch=vSwitch
    dhcp=false
    firewall=false
    ```
3. vim /etc/wsl.conf
    ```ini
    [boot]
    systemd=true

    [network]
    hostname=wsl
    generateResolvConf=false

    [interop]
    enabled=false
    appendWindowsPath=false

    [automount]
    options = "metadata"
    ```
4. vim /usr/lib/systemd/network/99-wsl.network
    ```ini
    [Match]
    Name=eth0
    [Network]
    Description=bridge
    DHCP=false
    Address=192.168.1.17/24
    Gateway=192.168.1.1
    DNS=192.168.1.1
    ```
5. 重启wsl;wsl --shutdown