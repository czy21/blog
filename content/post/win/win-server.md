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
## Windows Terminal
```powershell
# https://github.com/microsoft/microsoft-ui-xaml/releases/tag/v2.8.6
Add-AppxPackage .\Microsoft.UI.Xaml.2.8.x64.appx
# https://github.com/microsoft/terminal/releases/tag/v1.23.12371.0
Add-AppxPackage .\Microsoft.WindowsTerminal_1.23.12371.0_8wekyb3d8bbwe.msixbundle
```
## Docker Desktop
  - 不支持通过ssh执行docker-compose