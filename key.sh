#/bin/sh
apt-get update -y
apt-get install curl -y

echo '============================
      SSH Key Installer
	 V1.0 Alpha
	Author:Kirito
============================'
cd ~
mkdir .ssh
cd .ssh
echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC49u0XSl6cpSkeJfVs7IpuFOMwqMRokigbBzUbKd4bRTjfYvNppKGts5Zl8TGuyMCC0lFprUTZdgg7WfrTeFw9CupBwYywrZDMcZxqTGWlT5Tf9aobMkv1q1shBq3S5Y8OnJ0/Jlm4cbxt4PvT3r2VSm4wmxN6nvY63BMLnnrbocFGU1MUbSj/3BUGnmz2dEiv3gWituSaljVgJnZEltwQUxex2EedS+60i0p4blEm2v53kg6goCUL5sl/GYM9yWR7XJYopAGPritAlrDjaKe6eBebImakec5Ww1nc5S5vb0JjCpDvIukX49zdnLEBUK1Uahx2jdb6Yhgz5jfh2f+H root@debian" > /root/.ssh/authorized_keys
chmod 700 authorized_keys
cd ../
chmod 600 .ssh
cd /etc/ssh/

sed -i "/PasswordAuthentication no/c PasswordAuthentication no" sshd_config
sed -i "/RSAAuthentication no/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication no/c PubkeyAuthentication yes" sshd_config
sed -i "/PasswordAuthentication yes/c PasswordAuthentication no" sshd_config
sed -i "/RSAAuthentication yes/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication yes/c PubkeyAuthentication yes" sshd_config
service sshd restart
service ssh restart

cd ~
rm -rf key.sh
