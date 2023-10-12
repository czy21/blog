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
# skip microsoft login
# username: no@thanks.com
# password: nothanks
```
## KMS激活
https://github.com/Wind4/vlmcsd/tree/gh-pages
https://learn.microsoft.com/zh-cn/windows-server/get-started/kms-client-activation-keys
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