---
title: "ESXI8 Win11安装"
description: win11
keywords: "win11"

date: 2024-10-12T13:34:38+08:00
lastmod: 2024-10-12T13:34:38+08:00

categories:
  - win11
tags: 
  - win11
---
## Intel驱动安装 
- https://www.intel.cn/content/www/cn/zh/support/intel-driver-support-assistant.html

## KMS激活
- https://github.com/Wind4/vlmcsd/tree/gh-pages
- https://learn.microsoft.com/zh-cn/windows-server/get-started/kms-client-activation-keys
- Windows
  ```powershell
  slmgr /upk
  slmgr /skms 192.168.1.1
  slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
  slmgr /ato
  ```
- Office 2019
  ```powershell
  cd "C:\Program Files\Microsoft Office\Office16"
  foreach ($x in Get-ChildItem ..\root\Licenses16\*_KMS*.xrm-ms -name) {cscript ospp.vbs /inslic:"..\root\Licenses16\$x"}
  cscript ospp.vbs /sethst:192.168.1.1
  cscript ospp.vbs /inpkey:NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP
  cscript ospp.vbs /act
  slmgr /ato SKUID
  ```
## VLAN
- 启用Windows功能
![](vlan-feature.png)
```powershell
# 获取网卡信息
Get-NetAdapter
# 创建vSwitch
New-VMSwitch -name VLAN-vSwitch -NetAdapterName "Ethernet" -AllowManagementOS $true
# 创建vlan
Add-VMNetworkAdapter -ManagementOS -Name "<vlanName>" -SwitchName "VLAN-vSwitch" -Passthru | Set-VMNetworkAdapterVlan -Access -VlanId <vlanId>
```