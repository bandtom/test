官方给了两种方法。

第一种：

在/etc/default/grub文件的GRUB_CMDLINE_LINUX变量中添加IPV6_DISABLE=1，然后运行update-grub，最后重启服务器。

第二种：

编辑/etc/sysctl.conf，添加或者编辑以下变量：
```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
```
最后sysctl -p即可。

