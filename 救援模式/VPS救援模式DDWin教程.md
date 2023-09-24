系统要求：Debian 7 或 Ubuntu 12 以上
注意：VPS需要，默认以DHCP 自动分配IP 的才行，否则那种需要指定IP网关才有网络的，无法使用！

# 更新源
apt-get update

# 安装依赖
apt-get install wget grub2 grub-imageboot -y

# 创建ISO文件夹
mkdir /boot/images/

# 下载救援系统文件
wget --no-check-certificate -O /boot/images/mfslinux.iso http://d.nat.ee/rescue/mfslinux.iso

# 替换引导顺序默认启动为救援系统
sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=2/g' /etc/default/grub

# 更新引导
update-grub2

# 重启
reboot

重新用SSH连接，
SSH端口：22
用户名：root
密码：nat.ee

欢迎信息带有 OpenWrt 则成功进入。

假如未能进入到救援系统，需要重新使用
sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=2/g' /etc/default/grub

修改 GRUB_DEFAULT=2 为其他引导顺序，请多次尝试修改其他数字(1-9)，或者你最好重装系统后，再次使用此教程。


# 查看分区信息
fdisk -l

建议先测试DD包下载直链是否正常，然后再执行一键DD

# 创建名为DD的后台窗口进入。
screen -S DD

# 如果SSH中断，可以执行下面的命令恢复这个DD后台窗口。
screen -r DD

# 一键DD Windows
wget --no-check-certificate -qO- "Windows DD包下载直链" |gunzip -dc |dd of=/dev/vda

DD过程，是没有任何信息的。

视你的VPS：CPU/内存/硬盘读写/网速，以及DD包大小而决定DD要花多长时间，一般比较久，几十分钟到几小时或者一整天都有可能。

DD完成后会出现这种信息：
6291457+0 records in
6291457+0 records out

# 重启
reboot

重启后，并不是马上就能进入到你DD的Windows系统

还需要让此Windows系统 完成首次安装，一般5-30分钟不等的。

祝你成功！

网站：nat.ee
QQ群：6281379
TG群：https://t.me/nat_ee