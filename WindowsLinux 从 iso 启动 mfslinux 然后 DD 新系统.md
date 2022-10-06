# Windows/Linux 从 iso 启动 mfslinux 然后 DD 新系统

========================================================================
[Windows](https://369369.xyz/host/data/Windows.html) 系统
========================================================================

\1. 下载 [EasyBCD](https://369369.xyz/host/data/EasyBCD.html) 和 mfslinux

https://sm.myapp.com/original/System/[EasyBCD](https://369369.xyz/host/data/EasyBCD.html)_v2.3.exe
https://mfsbsd.vx.sk/files/iso/mfslinux/mfslinux-0.1.10-f9c75a4.iso

\2. 安装 [EasyBCD](https://369369.xyz/host/data/EasyBCD.html) 添加 mfslinux 启动菜单并设置为默认选项

![img](https://s2.loli.net/2022/10/06/1qZXRCcLTB2xEUl.png)



![img](https://s2.loli.net/2022/10/06/qmZOAbMxVDFy3PL.png)


\3. 重新启动

![img](https://s2.loli.net/2022/10/06/lXxSsnd5gM8RBtP.png)



![img](https://s2.loli.net/2022/10/06/l3p1zoDCAFNGIYy.png)


\4. 通过 SSH 连接

username: root
password: mfsroot

========================================================================
Linux 系统
========================================================================
\1. 控制面板安装 [Debian](https://369369.xyz/host/data/Debian.html) 11

\2. 下载、安装、启动 mfslinux

```
apt update && apt install grub2 grub-imageboot && \
mkdir -p /boot/images/ && \
wget --no-check-certificate -O /boot/images/mfslinux.iso https://mfsbsd.vx.sk/files/iso/mfslinux/mfslinux-0.1.10-f9c75a4.iso && \
sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=2/g' /etc/default/grub && \
update-grub2

reboot
```


\3. SSH 连接

username: root
password: mfsroot

========================================================================
DD Windows
========================================================================

安装进度条 -- 可选

```
opkg update && opkg install pv
```


DD 无进度

```
wget -O- "https://dl.lamp.sh/vhd/zh-cn_win2022.xz" | xzcat | dd of=/dev/vda
```


DD 带进度

```
wget -O- "https://dl.lamp.sh/vhd/zh-cn_win2022.xz" | xzcat | pv | dd of=/dev/vda
```


重启
reboot

RDP 连接
username: Administrator
password: Teddysun.com

========================================================================

DD [Debian]
========================================================================
安装进度条 -- 可选

```
opkg update && opkg install pv
```


DD 无进度

```
wget -O- "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-nocloud-amd64.raw" | dd of=/dev/vda
```


DD 带进度

```
wget -O- "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-nocloud-amd64.raw" | pv | dd of=/dev/vda
```

修复分区表

```
fdisk /dev/vda << EOF
w
q
EOF
```


设置root密码

```
mkdir /mnt/vda1 && mount /dev/vda1 /mnt/vda1 && chroot /mnt/vda1
```

```
ssh-keygen -A && \
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
passwd root
```

```
输入密码两次：
********
********
```

重启
reboot

SSH 连接
username: root
password: ********