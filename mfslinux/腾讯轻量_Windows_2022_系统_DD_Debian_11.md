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
```
wget -O- "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-genericcloud-amd64.raw" | dd of=/dev/vda
```
```
Download completed (2147483648 bytes)
4189053+9690 records in
4189053+9690 records out
```
6. mount
```
fdisk -l
GPT PMBR size mismatch (4194303 != 62914559) will be corrected by write. <=== 错误？

The backup GPT table is not on the end of the device.
Disk /dev/vda: 30 GiB, 32212254720 bytes, 62914560 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 2AC9A341-47CF-F740-B3FA-A9FF9D45F89A

Device      Start     End Sectors  Size Type
/dev/vda1  262144 4194270 3932127  1.9G Linux filesystem
/dev/vda14   2048    8191    6144    3M BIOS boot
/dev/vda15   8192  262143  253952  124M EFI System

Partition table entries are not in disk order.
```

无法 mount
```
mkdir /mnt/vda1
mount /dev/vda1 /mnt/vda1

NTFS signature is missing.
Failed to mount '/dev/vda1': Invalid argument
The device '/dev/vda1' doesn't seem to have a valid NTFS.
Maybe the wrong device is used? Or the whole disk instead of a
partition (e.g. /dev/sda, not /dev/sda1)? Or the other way around?
mount: mounting /dev/vda1 on /mnt/vda1 failed: Invalid argument
```
修复
```
fdisk /dev/vda

Welcome to fdisk (util-linux 2.36.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

GPT PMBR size mismatch (4194303 != 62914559) will be corrected by write.
The backup GPT table is not on the end of the device. This problem will be corrected by write.

Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
重新 mount
```
mount /dev/vda1 /mnt/vda1
ls /mnt/vda1/usr/local
```

>bin      etc      games    include  lib      man      sbin     share    src


此时并没有 /usr/local/qcloud 这个文件夹

7. 配置 SSH

允许 root 使用密码登录
```
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /mnt/vda1/etc/ssh/sshd_config
sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /mnt/vda1/etc/ssh/sshd_config
```


修改 root 密码
```
chroot /mnt/vda1/

passwd root
********
********

passwd -S root
root P 04/24/2022 0 99999 7 -1

cat /etc/shadow | grep root
root:$y$j9T$onpHR5WOJnsR2/G8ChkaH0$2vtxjM/PIMbULsMWQnfPwF/TKLT8gPDFjyESjlRz2E4:19106:0:99999:7:::

exit
umount /mnt/vda1/
```


8. 重启到 Debian 11
```
reboot
```

------
重启之后无法使用设置的 root 的密码登录。

通过控制面板【一键免密登录】登录，发现密码被修改了

重启之前
```
cat /etc/shadow | grep root
root:$y$j9T$onpHR5WOJnsR2/G8ChkaH0$2vtxjM/PIMbULsMWQnfPwF/TKLT8gPDFjyESjlRz2E4:19106:0:99999:7:::
```


重启之后
```
sudo cat /etc/shadow | grep root
root:$1$SCHOoGBY$qPO8vlLAXHuELwt.aEhDu0:19106:0:99999:7:::
```


同时多出来一个文件夹 /usr/local/qcloud
```
ls /usr/local
bin  etc  games  include  lib  man  qcloud  sbin  share  src
```

尝试重新设置 root 密码
```
sudo passwd root
New password:
Retype new password:
passwd: password updated successfully

sudo cat /etc/shadow | grep root
root:$y$j9T$T76Q00rHl.AWo4XebXcPB/$wBLwqUl5XhvjUAGQFx/NLhcz5zHrVEU0oTr9uIZEJM3:19106:0:99999:7:::
```

然后就可以顺利的使用新密码登录了。

------

## 使用 nocloud 映像可以直接登录了，并且也没有 /usr/local/qcloud 文件夹
```
https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-nocloud-amd64.raw
```
控制面板看不到cpu和内存数据

```
wget -O- "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-nocloud-amd64.raw" | dd of=/dev/vda

fdisk /dev/vda << EOF
w
q
EOF

mkdir /mnt/vda1 && mount /dev/vda1 /mnt/vda1 && chroot /mnt/vda1

ssh-keygen -A && \
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
passwd root
********
********

reboot
```
