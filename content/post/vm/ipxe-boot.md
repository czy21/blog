---
title: "IPXE 无盘引导"
description: ipxe
keywords: "ipxe"

date: 2023-10-08T09:39:58+08:00
lastmod: 2023-10-12T10:39:58+08:00

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
cat << EOF > script.ipxe
#!ipxe
dhcp
chain --autofree tftp://\${next-server}/boot.ipxe
#chain --autofree https://boot.netboot.xyz
EOF
```
- UEFI
  ```shell
  git checkout config/general.h
  sed -i 's|#undef.*\(DOWNLOAD_PROTO_HTTPS\)|#define \1|' config/general.h
  make bin-x86_64-efi/ipxe.efi EMBED=script.ipxe
  ```
- BIOS
  ```shell
  git checkout config/general.h
  sed -i 's|#undef.*\(DOWNLOAD_PROTO_HTTPS\)|#define \1|' config/general.h
  sed -i 's|\/\/#define.*\(IMAGE_COMBOOT\)|#define \1|' config/general.h
  make bin/undionly.kpxe EMBED=script.ipxe
  ```