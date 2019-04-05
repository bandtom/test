# test
Python上传命令

python SimpleHTTPServerWithUpload.py 9999

魔改BBR修改模块备份

tcp_tsunami.c

手动修改端口成功了，需要改端口的可以照这样来操作。编辑/etc/init.d/kms文件，将$DAEMON -p $PID_FILE这段改成$DAEMON -P(端口号) -p $PID_FILE，如$DAEMON -P30000 -p $PID_FILE,即端口号改成30000。然后重启KMS服务，搞定。

今天搞了半天没法激活office vol，后来用 cscript ospp.vbs /dstatus 查看了kms信息，发现默认端口是1686。
所以设定ip后需要增加一条命令改端口 cscript ospp.vbs /setprt:1688
然后再执行 cscript ospp.vbs /act 搞定


