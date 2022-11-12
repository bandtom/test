Ubuntu Server 22.04 LTS (Jammy Jellyfish) released builds

https://cloud-images.ubuntu.com/  
https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img  

不要被这货的后缀.img所蒙蔽了，实际上是qcow2镜像！

使用qemu-img转换格式: raw, qcow2, qed, vdi, vmdk, vhd

rpm系

dnf install -y qemu-img

deb系

apt install -y qemu-utils

然后转换

qemu-img convert -f qcow2 -O raw ubuntu-22.04-server-cloudimg-amd64.img ubuntu-22.04-server-cloudimg-amd64.raw

具体看这里

Converting between image formats — Virtual Machine Image Guide documentation.mhtml

https://docs.openstack.org/image-guide/convert-images.html

接着安装kpartx

rpm系

dnf install -y kpartx

deb系

apt install -y kpartx

然后挂载镜像

kpartx -av ubuntu-22.04-server-cloudimg-amd64.raw

mount /dev/mapper/loopX /mnt

以实际硬盘分区为准，运行kpartx -av ubuntu-22.04-server-cloudimg-amd64.raw有提示。

改网卡名为eth0，并自动获取dhcpv4、dhcpv6地址

需要改MAC地址为实际的

通过ip addr show获取实际MAC地址
```
cat <<EOF> /mnt/etc/netplan/config.yaml
network:
    version: 2
    renderer: networkd
    ethernets:
        eth0:
            dhcp4: true
            dhcp6: true
            match:
                macaddress: 00:00:00:00:00:20
            set-name: eth0
EOF
```
改ssh允许root密码登录
```
nano /mnt/etc/ssh/sshd_config
PermitRootLogin yes
PasswordAuthentication yes
```
改root密码   
获取密码
```
[root@r ~]# openssl passwd -1 https://hostloc.com/
$1$1UVdmoQe$MKwgVugqOmLxeSo7q7lLo1
设置root密码为“https://hostloc.com/”
nano /mnt/etc/shadow
root:$1$1UVdmoQe$MKwgVugqOmLxeSo7q7lLo1:18849:0:99999:7:::
```
设置开机启动

狗日的ubuntu云镜像没有主机密钥，别的都有的，不加没办法登录
```
cp -f /mnt/usr/lib/systemd/system/rc-local.service /mnt/etc/systemd/system/
cat <<EOF> /mnt/etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

ssh-keygen -A
exit 0
EOF

chmod +x /mnt/etc/rc.local
```
至此全部完成基于官方云镜像的最新版系统！

DD方法请看

https://hostloc.com/thread-1009703-1-1.html
