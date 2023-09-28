---
title: "ESXI8 Win11安装"
description: exsi-win11
keywords: "exsi,win11"

date: 2023-09-28T10:20:58+08:00
lastmod: 2023-09-28T10:20:58+08:00

categories:
  - exsi
tags: 
  - win11
---

## 跳过TPM检查
```shell
# install shift+F10
REG ADD HKLM\SYSTEM\Setup\LabConfig /v BypassTPMCheck /t REG_DWORD /d 1
REG ADD HKLM\SYSTEM\Setup\LabConfig /v BypassSecureBootCheck /t REG_DWORD /d 1
# init shift+F10
OOBE\BYPASSNRO
```