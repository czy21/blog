---
title: "IPXE 无盘引导"
description: ipxe
keywords: "ipxe"

date: 2023-10-08T09:39:58+08:00
lastmod: 2023-10-08T09:39:58+08:00

categories:
  - ipxe
tags: 
  - ipxe
---

## IPXE编译(Ubuntu 22.04)
```shell
apt install gcc binutils make perl liblzma-dev mtools mkisofs syslinux
git clone git://git.ipxe.org/ipxe.git
cd ipxe/src
# 编译传统引导
make bin/undionly.kpxe
```