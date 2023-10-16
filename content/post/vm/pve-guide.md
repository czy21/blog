---
title: "PVE 安装 硬件直通"
description: pve
keywords: "pve"

date: 2023-10-13T12:00:00+08:00
lastmod: 2023-10-13T12:00:00+08:00

categories:
  - pve
tags: 
  - pve
---

## Remove subscription
  - vim proxmoxlib.js
    ```shell
    vim /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
    /checked_command
    ```
  - ```js
    checked_command: function(orig_cmd) {
		  orig_cmd();
    },
    ```
  - ```shell
    systemctl restart pveproxy.service
    ```
  - CTRL+F5 Refresh Brower
## Enable IOMMU 
- AMD
  ```shell
  sed 's|\(GRUB_CMDLINE_LINUX_DEFAULT\)=\(.*\)|\1="quiet amd_iommu=on iommu=pt"|' /etc/default/grub
  ```
- INTEL
  ```shell
  sed 's|\(GRUB_CMDLINE_LINUX_DEFAULT\)=\(.*\)|\1="quiet intel_iommu=on iommu=pt"|' /etc/default/grub
  ```
```shell
update-grub
```
## Kernel Modules
```shell
cat << EOF > /etc/modules
# /etc/modules: kernel modules to load at boot time.
#
# This file contains the names of kernel modules that should be loaded
# at boot time, one per line. Lines beginning with "#" are ignored.
# Parameters can be specified after the module name.

vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
EOF
update-initramfs -u -k all 
reboot
```
## Verify
```shell
dmesg | grep iommu
# hav output is success
find /sys/kernel/iommu_groups/ -type l
```
## GPU passthrough
  - AMD
    ```shell
    cat << EOF > /etc/modprobe.d/blacklist.conf 
    blacklist radeon
    blacklist amdgpu
    EOF
    ```
  - NVIDIA
    ```shell
    cat << EOF > /etc/modprobe.d/blacklist.conf
    blacklist nouveau
    blacklist nvidia*
    EOF
    ```
## Allow unsafe interrupt
```shell
echo "options vfio_iommu_type1 allow_unsafe_interrupts=1" > /etc/modprobe.d/iommu_unsafe_interrupts.conf
```
## Ignore vm exception
```shell
echo "options kvm ignore_msrs=1 report_ignored_msrs=0" > /etc/modprobe.d/kvm.conf
```
## Set passthrough ids
```shell
# show pcie device
lspci -nn
# set passthrough ids
echo "options vfio-pci ids=xxxx:xxxx,yyyy:yyyy" > /etc/modprobe.d/vfio.conf
# verify
lspci -nnk
update-initramfs -u -k all
reboot
```
## Disk passthrough
  - RDM
  ```shell
  ls -la /dev/disk/by-id/|grep -v dm|grep -v lvm|grep -v part
  # type: scsi sata ide
  # example: qm set <vmid> --scsi0 /dev/disk/by-id/xxxx
  qm set <vmid> --<type><sequence> /dev/disk/by-id/xxxx
  # delete passthrough
  qm set <vmid> --delete scsi0
  ```
## Reference
  - https://pve.proxmox.com/wiki/PCI_Passthrough
  - https://pve.proxmox.com/wiki/PCI(e)_Passthrough
  - https://foxi.buduanwang.vip/virtualization/pve/561.html
  - https://foxi.buduanwang.vip/virtualization/1754.html
  - https://foxi.buduanwang.vip/virtualization/375.html