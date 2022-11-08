如有必要请在修改的覆盖的操作前做好备份, 下面内容可按需复制或抄写，比如我一般只用中科大源

### 1. 修改文件 /etc/apt/sources.list 为下面内容

下面内容中默认开启了中科大的源，请根据自己需求决定使用哪个源。 方法： 直接取消注释就好



```shell
# Debian 10 buster

# 中科大源

deb http://mirrors.ustc.edu.cn/debian buster main contrib non-free
deb http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
deb http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
deb http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free

# deb-src http://mirrors.ustc.edu.cn/debian buster main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
# deb-src http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free

# 官方源

# deb http://deb.debian.org/debian buster main contrib non-free
# deb http://deb.debian.org/debian buster-updates main contrib non-free
# deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free

# deb-src http://deb.debian.org/debian buster main contrib non-free
# deb-src http://deb.debian.org/debian buster-updates main contrib non-free
# deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

# 网易源

# deb http://mirrors.163.com/debian/ buster main non-free contrib
# deb http://mirrors.163.com/debian/ buster-updates main non-free contrib
# deb http://mirrors.163.com/debian/ buster-backports main non-free contrib
# deb http://mirrors.163.com/debian-security/ buster/updates main non-free contrib

# deb-src http://mirrors.163.com/debian/ buster main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster-updates main non-free contrib
# deb-src http://mirrors.163.com/debian/ buster-backports main non-free contrib
# deb-src http://mirrors.163.com/debian-security/ buster/updates main non-free contrib

# 阿里云

# deb http://mirrors.aliyun.com/debian/ buster main non-free contrib
# deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
# deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
# deb http://mirrors.aliyun.com/debian-security buster/updates main

# deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib
# deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib
# deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib
# deb-src http://mirrors.aliyun.com/debian-security buster/updates main
```

### 2. 直接用此文件覆盖掉源

请依次执行：

1. 下载设置好的源文件
2. 覆盖现有源
3. 更新软件列表并更新软件



```shell
wget http://qiniu.xiwen.online/Debian10.list
sudo mv Debian10.list /etc/apt/sources.list
sudo apt update && sudo apt upgrade -y
```

文件内容与上面代码内容相同

