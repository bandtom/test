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
curl https://github.com/bandtom.keys > authorized_keys
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


cd ~
rm -rf key.sh