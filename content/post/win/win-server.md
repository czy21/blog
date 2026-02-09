---
title: "WinServer环境配置"
description: win-server
keywords: "win-server"

date: 2024-10-12T13:50:38+08:00
lastmod: 2025-09-12T13:50:38+08:00

categories:
  - win-server
tags: 
  - win-server
---
## Download
  - https://www.microsoft.com/zh-cn/evalcenter/download-windows-server-2025
  - https://www.microsoft.com/zh-cn/evalcenter/download-windows-server-2022
## 评估转正式
```powershell
# 获取当前版本
DISM /Online /Get-CurrentEdition
# 设置为目标版本
DISM /Online /Set-Edition:ServerDatacenter /ProductKey:<productKey> /AcceptEula
```
## Key
| Version | Key       |
|:--------|:----------|
| Windows Server 2025 Standard      | TVRH6-WHNXV-R9WG3-9XRFY-MY832    |
| Windows Server 2025 Datacenter    | D764K-2NDRG-47T6Q-P8T8W-YP6DF    |
## WinRM
```powershell
# 快速配置 WinRM（开发环境）
Enable-PSRemoting -Force

# 设置 WinRM 服务自动启动
Set-Service WinRM -StartupType Automatic

# 配置基础认证
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# 添加信任的主机（允许所有主机连接）
winrm set winrm/config/client '@{TrustedHosts="*"}'
```
## OpenSSH
```powershell
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

Start-Service sshd

Set-Service -Name sshd -StartupType 'Automatic'
```
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

## WSL 服务对外开放
  - 网络模式仅支持NAT,通过portproxy将wsl的服务端口映射到windows的远程端口,即可实现访问
```powershell
$wsl_ip = wsl hostname -I | ForEach-Object {
    $_.Trim().Split()[0]
}

Write-Host "WSL IP: $wsl_ip"

netsh interface portproxy reset

netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=12222 connectaddress=$wsl_ip connectport=2222

netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=16008 connectaddress=$wsl_ip connectport=6008

netsh interface portproxy show all
```

## Windows Terminal
```powershell
# https://github.com/microsoft/microsoft-ui-xaml/releases/tag/v2.8.6
Add-AppxPackage .\Microsoft.UI.Xaml.2.8.x64.appx
# https://github.com/microsoft/terminal/releases/tag/v1.23.12371.0
Add-AppxPackage .\Microsoft.WindowsTerminal_1.23.12371.0_8wekyb3d8bbwe.msixbundle
```
## Docker Desktop
  - 不支持通过ssh执行docker-compose