---
title: "WinServer配置大全"
description: win-server
keywords: "win-server"

date: 2024-10-12T13:50:38+08:00
lastmod: 2024-10-12T13:50:38+08:00

categories:
  - win-server
tags: 
  - win-server
---
## 评估转正式
```powershell
# 获取当前版本
DISM /Online /Get-CurrentEdition
# 设置为目标版本
DISM /Online /Set-Edition:ServerDatacenter /ProductKey:<productKey> /AcceptEula
```