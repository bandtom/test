# test
Python上传命令

python SimpleHTTPServerWithUpload.py 9999

魔改BBR修改模块备份

tcp_tsunami.c


DEBIAN9 启动项开启

cat <<EOF >/etc/rc.local
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
#  SS+KCP+UDP2RAW 加速  端口  8855
ss-server -s 127.0.0.1 -p 40000 -k ${PASSWORD} -m aes-256-gcm -t 300 >> /var/log/ss-server.log &
kcp-server -t "127.0.0.1:40000" -l ":4000" -mode fast2 -mtu 1300  >> /var/log/kcp-server.log &
udp2raw -s -l0.0.0.0:8855 -r 127.0.0.1:4000 -k "passwd" --raw-mode faketcp  >> /var/log/udp2raw.log &
# WireGuard + UDP2RAW 伪装 TCP  预留端口  8866
udp2raw -s -l0.0.0.0:8866 -r 127.0.0.1:9009 -k "passwd" --raw-mode faketcp  >> /var/log/wg_udp2raw.log &
exit 0
EOF

chmod +x /etc/rc.local
systemctl restart rc-local



