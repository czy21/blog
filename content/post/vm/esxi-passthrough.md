---
title: "ESXI8 硬件直通"
description: exsi-passthrough
keywords: "exsi,passthrough,直通"

date: 2023-09-28T10:20:58+08:00
lastmod: 2023-09-28T10:20:58+08:00

categories:
  - exsi
tags: 
  - passthrough
---
## RDM硬盘直通{0} 硬盘挂载地址, {1} 生成目标映射地址
```shell
vmkfstools -z /vmfs/devices/disks/t10.ATA_____xxxxxxxxxxxxxxxxxxxx /vmfs/volumes/datastore/disk0.vmdk
vmkfstools -z /vmfs/devices/disks/t10.ATA_____yyyyyyyyyyyyyyyyyyyy /vmfs/volumes/datastore/disk1.vmdk
```

## 直通usb键鼠
```shell
# list usb device
lsusb
# vi /etc/vmware/config
usb.generic.allowHID = "TRUE"
usb.quirks.device0 = "0x1bcf:0x08b8 allow"
usb.quirks.device1 = "0x04d9:0x1702 allow"

# vi /bootbank/boot.cfg
CONFIG./USB/quirks=0x1bcf:0x08b8::0xffff:UQ_KBD_IGNORE:0x04d9:0x1702::0xffff:UQ_KBD_IGNORE
```