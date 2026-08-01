---
title: "OpenWRT"
description: "build"
keywords: "build"

date: 2023-08-08T14:36:15+08:00
lastmod: 2023-08-21T09:26:35+08:00

categories:
  - openwrt
tags:
  - build
  -
---
## Overlay 扩容
```shell
mnt <device> <dir>
tar -C /overlay -cvf - . | tar -C <dir> -xf -
```
## 常见问题
 * cron.err xxxxxx 意为cron执行过任务,不是任务内部出错

## 内核启动;串口进入U-Boot
```shell
setenv ipaddr 192.168.1.1
setenv serverip 192.168.1.2
ping 192.168.1.2

tftpboot 0x46000000 kernel.bin
bootm 0x46000000
```

## 其他
```shell
# 计算内存地址
printf "0x%x\n" $((0x580000+0x6c00000))
# 查看wifi驱动日志
dmesg | grep -i mt79
```

## 刷bl2+uboot, TTL ESC进入 MT7981 >;tftpboot 0x46000000 <filename> 从tftp服务端下载文件到0x46000000内存地址
- 备份原厂分区
```shell
setenv serverip 192.168.1.254
tftpboot 0x46000000 openwrt-25.12.5-mediatek-filogic-ikuai_q3000-initramfs-kernel.bin
bootm 0x46000000

# scp备份mtd分区
ssh root@192.168.1.1
# root@OpenWrt:~# 
mkdir -p /tmp/mtd;cat /proc/mtd > /tmp/mtd/.mtd;for m in $(awk -F'[: "]+' '/mtd[0-9]+/{print $1}' /proc/mtd); do n=$(cat /sys/class/mtd/$m/name); dd if=/dev/$m of=/tmp/mtd/${n}.bin bs=1M; done
scp -O -r root@192.168.1.1:/tmp/mtd/ .
```
## mtd layout
  ```shell
  mtd erase bl2
  tftpboot 0x46000000 openwrt-mediatek-filogic-ikuai_q3000-ubootmod-preloader.bin
  mtd write bl2 0x46000000

  mtd erase fip
  tftpboot 0x46000000 openwrt-mediatek-filogic-ikuai_q3000-ubootmod-bl31-uboot.fip
  mtd write fip 0x46000000

  run ubi_format
  run boot_tftp_production
  reset
  ```
## ubi layout
- 拔电执行mtk_uartboot(可救砖)
  ```powershell
  # https://github.com/981213/mtk_uartboot
  # https://downloads.openwrt.org/releases/25.12.5/targets/mediatek/filogic/mt7981-ram-ddr3-bl2.bin
  # 执行该命令 不能有其他串口访问115200
  ./mtk_uartboot.exe --payload ./mt7981-ram-ddr3-bl2.bin --aarch64 --fip ./openwrt-mediatek-filogic-ikuai_q3000-ubi-bl31-uboot.fip
  # mtk_uartboot - 0.1.1
  # Using serial port: COM3
  # Handshake...
  # hw code: 0x7981
  # hw sub code: 0x8a00
  # hw ver: 0xca00
  # sw ver: 0x1
  # Baud rate set to 460800
  # sending payload to 0x201000...
  # Checksum: 0xf854
  # Setting baudrate back to 115200
  # Jumping to 0x201000 in aarch64...
  # Waiting for BL2. Message below:
  # ==================================
  # NOTICE:  BL2: v2.13.0(release):OpenWrt v2025.07.11~78a0dfd9-1 (mt7981-ram-ddr3)
  # NOTICE:  BL2: Built : 12:59:20, Jun 29 2026
  # NOTICE:  WDT: Cold boot
  # NOTICE:  WDT: disabled
  # NOTICE:  EMI: Using DDR3 settings
  # NOTICE:  EMI: Detected DRAM size: 512MB
  # NOTICE:  EMI: complex R/W mem test passed
  # NOTICE:  CPU: MT7981 (1300MHz)
  # NOTICE:  Starting UART download handshake ...
  # ==================================
  # BL2 UART DL version: 0x10
  # Baudrate set to: 921600
  # FIP sent.
  # ==================================
  # NOTICE:  Received FIP 0xc583c @ 0x40400000 ...
  # ==================================
  ```
- TTL COMx 115200; ESC进入MT7981>
  ```shell
  mtd list
  setenv serverip 192.168.1.254
  run boot_tftp_write_bl2
  
  # 重建ubi分区
  ubi list
  ubi remove <volume_name>
  nand erase.part ubi
  ubi create factory 0x200000

  # 刷入原厂factory
  tftpboot 0x46000000 factory.bin
  ubi write 0x46000000 factory ${filesize}

  # 刷入UBoot
  run boot_tftp_write_fip
  # 刷入OpenWrt
  run boot_tftp_production
  reset
  ```