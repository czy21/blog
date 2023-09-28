---
title: "ESXI 封装驱动"
description: exsi-driver
keywords: "exsi,driver"

date: 2023-09-28T10:20:58+08:00
lastmod: 2023-09-28T10:20:58+08:00

categories:
  - exsi
tags: 
  - driver
---

## windows powershell执行
```powershell
Install-Module -Name VMware.PowerCLI -RequiredVersion 12.0.0.15947286
Set-ExecutionPolicy RemoteSigned
```
## 脚本导入
```powershell
.\ESXi-Customizer-PS.ps1 -izip .\VMware-ESXi-7.0U3d-19482537-depot.zip -pkgDir .\pkg\
```