如何检测我的VPS服务器是否支持DD Windows

在Debian/Ubuntu 下

安装: apt-get install virt-what

执行命令: virt-what

两串命令，就知道能不能ddwin
只要显示为kvm/xen/hyper-v
这三个都可以，其他不行。

----------

然后就是检测 UEFI 或 BIOS 引导启动

安装: apt-get install efibootmgr

执行命令: efibootmgr

显示为：
EFI variables are not supported on this system.
则是BIOS引导启动

显示为其他则是UEFI引导启动

本站提供的DD包分别对应这两种引导启动模式而制作的，注意区分选择使用。

例如1: DD包文件名称，winsrv2016-data-x64-cn.vhd.gz 适合在BIOS引导启动

例如2: DD包文件名称，winsrv2016-data-x64-cn-efi.vhd.gz 适合在UEFI引导启动
会在DD包文件名称末尾带有 -efi

注意: 本站一直如此区分这两种引导启动模式，而命名DD包文件名称，请牢记。
