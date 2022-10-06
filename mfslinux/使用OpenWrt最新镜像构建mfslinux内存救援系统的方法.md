# 使用OpenWrt最新镜像构建mfslinux内存救援系统的方法

```
# 创建临时文件夹tmp 重启就没了
mount -t tmpfs tmpfs /tmp/
cd /tmp

# 下载OpenWrt镜像
wget https://downloads.openwrt.org/releases/22.03.0-rc1/targets/x86/64/openwrt-22.03.0-rc1-x86-64-generic-ext4-combined.img.gz

# 解压
gzip -kd openwrt-22.03.0-rc1-x86-64-generic-ext4-combined.img.gz

# 加载img镜像
kpartx -av openwrt-22.03.0-rc1-x86-64-generic-ext4-combined.img
add map loop1p1 (253:3): 0 32768 linear 7:7 512
add map loop1p2 (253:4): 0 212992 linear 7:7 33792

# 挂载img镜像分区
mount /dev/mapper/loop1p2 /mnt

# 进入/mnt目录
cd /mnt

# 修改root密码
openssl passwd -1 https://dns.google/
$1$JbwU3xW8$2tJF3BZ6NiSzEjDWXndBm1
nano etc/shadow
root:$1$JbwU3xW8$2tJF3BZ6NiSzEjDWXndBm1::0:99999:7:::

# 修改网络为IPV4 & IPV6 DHCP Client
nano etc/config/network

config interface 'loopback'
        option device 'lo'
        option proto 'static'
        option ipaddr '127.0.0.1'
        option netmask '255.0.0.0'

config device
        option name 'br-lan'
        option type 'bridge'
        list ports 'eth0'

config interface 'lan'
        option device 'br-lan'
        option proto 'dhcp'

config interface 'ipv6'
        option device 'br-lan'
        option proto 'dhcpv6'


# 复制init到/目录
cp sbin/init ./

# 压缩openwrt /目录为initramfs.igz
find . | cpio -H newc -o | gzip > initramfs.igz

# 下载OpenWrt内核 并改名vmlinuz
wget -O vmlinuz https://downloads.openwrt.org/releases/22.03.0-rc1/targets/x86/64/openwrt-22.03.0-rc1-x86-64-generic-kernel.bin

# 下载mfslinux镜像
wget https://mfsbsd.vx.sk/files/iso/mfslinux/mfslinux-0.1.10-f9c75a4.iso

# 把initramfs.igz和vmlinuz复制到mfslinux-0.1.10-f9c75a4.iso
用UltraISO打开mfslinux-0.1.10-f9c75a4.iso
把initramfs.igz 拖入mfslinux-0.1.10-f9c75a4.iso覆盖
把ivmlinuz 拖入mfslinux-0.1.10-f9c75a4.iso覆盖
然后保存

# 改启动菜单名字 （可省略）
用UltraISO打开mfslinux-0.1.10-f9c75a4.iso
修改boot.txt文件

mfslinux 0.1.10 f9c75a4
Copyright (c) 2022 Martin Matuska <mm at matuska dot de>

a - Boot mfslinux (OpenWrt 21.02.2)

# 官方镜像软件包没几个 需要按自己需求安装软件包
比如

opkg update
opkg install coreutils-dd
opkg install curl
opkg install kmod-fs-ntfs
opkg install kmod-fs-xfs
opkg install nano-full
opkg install openssh-sftp-server

# 求个大佬解答一下Ubuntu如何挂载iso并对其进行修改 谢谢
把initramfs.igz和vmlinuz复制到mfslinux-0.1.10-f9c75a4.iso
用UltraISO打开mfslinux-0.1.10-f9c75a4.iso
把initramfs.igz 拖入mfslinux-0.1.10-f9c75a4.iso覆盖
把ivmlinuz 拖入mfslinux-0.1.10-f9c75a4.iso覆盖
然后保存
```
