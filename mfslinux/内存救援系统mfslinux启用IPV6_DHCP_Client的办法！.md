# 内存救援系统mfslinux启用IPV6 DHCP Client的办法！

```
# mfslinux 内存救援系统简单介绍
可以加载系统到内存运行对硬盘进行救援，也可以 DD 系统，类似于 WinPE 系统。
mfslinux 基于 openwrt 系统。

# mfslinux GitHub 项目
https://github.com/mmatuska/mfslinux/
https://github.com/mmatuska/mfslinux/blob/master/config/default/network

# mfslinux 官方镜像
https://mfsbsd.vx.sk/files/iso/mfslinux/
https://mfsbsd.vx.sk/files/iso/mfslinux/mfslinux-0.1.10-f9c75a4.iso

# mfslinux 默认用户名密码端口
root
22
mfslinux


# 生成支持 IPV4 & IPV6 DHCP Client 的 iso 镜像

# 安装必须得包
apt update
apt install openssl git mkisofs genisoimage make

# 同步代码
git clone https://github.com/mmatuska/mfslinux.git

# 进入 mfslinux 目录
cd mfslinux/

# 新增支持 IPV6 DHCP Client
cat <<EOF>> config/default/network
config interface 'ipv6'
        option device 'eth0'
        option proto 'dhcpv6'
        option reqaddress 'try'
        option reqprefix 'auto'
EOF

# 增加包 不然加载 iso 进去又要安装 才能 DD 系统
cat <<EOF>> config/default/openwrt_packages_add
packages/gzip_1.10-3_x86_64.ipk
packages/pv_1.6.6-1_x86_64.ipk
packages/coreutils_8.32-6_x86_64.ipk
packages/coreutils-dd_8.32-6_x86_64.ipk
EOF

# 开始生成 iso 并设置自定义 root 密码
make ROOTPW=passwd

# 也可以用官方镜像进去之后再开 IPV6
uci set network.ipv6=interface
uci set network.ipv6.device='eth0'
uci set network.ipv6.proto='dhcpv6'
uci set network.ipv6.reqaddress='try'
uci set network.ipv6.reqprefix='auto'
uci commit network
/etc/init.d/network restart

# 再安装 DD 系统必备的包
opkg update
opkg install pv
opkg install gzip
opkg install coreutils-dd

# 手动设置静态 ip 地址的办法
network.lan.ipaddr='164.92.101.15'
network.lan.netmask='255.255.240.0'
network.lan.gateway='164.92.96.1'
network.lan.dns='1.1.1.1'
network.lan.ip6addr='2604:a880:4:1d0::622:0/64'
network.lan.ip6gw='2604:a880:4:1d0::1'
uci commit network
/etc/init.d/network restart

```

```
看代码是用gzip压缩的/目录

无非就是下载openwrt最新版x86_64的img镜像 转vmdk 虚拟机运行 安装必备软件工具 然后关机 把openwrt虚拟机的硬盘 加入到其他虚拟机 用其他虚拟机挂载openwrt / 目录 gzip 压缩为initramfs.igz

再挂载mfslinux官方iso镜像 删除initramfs.igz 复制新的initramfs.igz进入到iso 取消挂载
完成
```

```
下载nano的时候提示错误
那就从packages/nano_6.2-2_x86_64.ipk
这里开始查地址对不对得上
发现是nano包地址被改变了（换了新包，把旧包删除了）
编辑 config/default/openwrt_packages_add 把下面这个删除就得了
packages/nano_6.2-2_x86_64.ipk
或者换成新的版本
packages/nano_6.3-1_x86_64.ipk
```

