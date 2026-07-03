---
title: "crDroid刷机"
keywords: "android"

date: 2026-07-03T20:10:58+08:00
lastmod: 2026-07-03T20:10:58+08:00

categories:
  - android
tags: 
  - android
---
# XiaoMi Note 3 https://crdroid.net/jason/11/install
- https://developer.android.com/tools/releases/platform-tools
- https://twrp.me/app/
- https://magiskmanager.com/
- https://topjohnwu.github.io/Magisk/install.html

## Flash Recovery
```shell
fastboot flash recovery twrp.img
```
## Wipe data / Factory reset
## Adb sideload
```shell
adb sideload firmware.zip
adb sideload crdroid.zip
adb sideload gapps.zip
adb sideload magisk.zip
```