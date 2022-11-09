1. 下载 EasyBCD 和 mfslinux

https://sm.myapp.com/original/System/EasyBCD_v2.3.exe

https://mfsbsd.vx.sk/files/iso/mfslinux/mfslinux-0.1.10-f9c75a4.iso

2. 安装 EasyBCD 添加 mfslinux 启动菜单并设置为默认选项

![1](https://github.com/bandtom/test/blob/master/mfslinux/img/%E8%85%BE%E8%AE%AF%E8%BD%BB%E9%87%8F_Windows_2022_%E7%B3%BB%E7%BB%9F_DD_Debian_11-1.png)

3. 重新启动

![2](https://github.com/bandtom/test/raw/master/mfslinux/img/%E8%85%BE%E8%AE%AF%E8%BD%BB%E9%87%8F_Windows_2022_%E7%B3%BB%E7%BB%9F_DD_Debian_11-2.png)

4. 通过 SSH 连接

username: root  
password: mfsroot

5. 开始 DD
```
fdisk -l
Disk /dev/vda: 30 GiB, 32212254720 bytes, 62914560 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xf8c3d85e

Device     Boot Start      End  Sectors Size Id Type
/dev/vda1  *     2048 62910463 62908416  30G  7 HPFS/NTFS/exFAT
```
------
### 使用此镜像无法登陆，必须通过VNC修改密码才行  
https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-genericcloud-amd64.raw

------
