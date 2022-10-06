# VPS 虚拟服务器 DD 任何系统 最安全的办法！

1 任何Linux系统先dd成Debian 11

1.1 一般VPS用这个脚本就行了，用户名“root”，密码“https://example.com/”，端口“2222”

```
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') -d 11 -v 64 -p "https://example.com/" -port "2222"
```

1.2 比如谷歌云之类的内网IP的，需要指定内网地址，内网掩码，内网网关。用户名“root”，密码“https://example.com/”，端口“2222”

```
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/MoeClub/Note/master/InstallNET.sh') --ip-addr 10.0.0.2 --ip-gate 10.0.0.1 --ip-mask 255.255.255.0 -d 11 -v 64 -p "https://example.com/" -port "2222"
```

2 DD成Debian 11系统之后（通过脚本DD的，不知道有没有后门，就当它有后门吧），再运行内存救援系统mfslinux（基于openwrt）
```
# 更新包列表
apt update

# 安装必备的软件包
apt install -y grub2 grub-imageboot

# 创建iso文件夹目录
mkdir -p /boot/images/

# 下载mfslinux内存救援系统
wget --no-check-certificate -O /boot/images/mfslinux.iso https://mfsbsd.vx.sk/files/iso/mfslinux/mfslinux-0.1.10-f9c75a4.iso

# 设置GRUB开机启动为mfslinux
sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=2/g' /etc/default/grub

# 重新生成grub
update-grub2

# 重启进入mfslinux
reboot
```
默认用户“root”  
默认密码“mfslinux”  
默认端口“22”  

3进入内存救援系统之后安装必备的软件包

3.1 安装必备软件包

```
# 更新包列表
opkg update

# 安装进度显示pv包
opkg install pv

# 安装必备的gzip包
opkg install gzip

# 安装dd完整功能包
opkg install coreutils-dd
```

4 DD任何基于raw/img原始镜像系统，包括压缩为zip、gz、xz……格式的。

4.1 DD 官方Debian 11云镜像系统 raw/img原始镜像

```
wget -O- "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-genericcloud-amd64.raw" | pv | dd of=/dev/实际硬盘位置 bs=4M oflag=sync
```

4.2 DD raw/img镜像压缩为zip/gz格式的系统

```
wget -O- https://download.mikrotik.com/routeros/7.3beta37/chr-7.3beta37.img.zip | pv | zcat | dd of=/dev/实际硬盘位置 bs=4M oflag=sync
```

4.3 运行lsblk查看判断实际硬盘位置  

4.4 有些云镜像只有qcow2格式，需要转成raw才能DD，为了提高效率，可以压缩为zip/gz格式的！弄个VPS开nginx提供http下载  

```
qemu-img convert -f qcow2 -O raw image.qcow2 image.raw
```

5 修改云镜像的密码

5.1 DD完之后，挂载硬盘，打开系统所在分区的/etc/目录

```
mount /dev/sda1 /mnt
```

硬盘位置和系统所在分区以实际为准！
运行lsblk查看判断

5.2 获取密码

```
#openssl passwd -1 https://example.com/
$1$1UVdmoQe$MKwgVugqOmLxeSo7q7lLo1
```

5.3 设置root密码为https://example.com/

```
nano /mnt/etc/shadow
root:$1$1UVdmoQe$MKwgVugqOmLxeSo7q7lLo1:18849:0:99999:7:::
```

6 修改ssh允许root登录、允许密码登录

```
nano /mnt/etc/ssh/sshd_congfig
```

找到下面这两项改成yes，其他的不要改。如果有相同启用了的选项在前面加#

```
PermitRootLogin yes
PasswordAuthentication yes
```

至此全部完成！
