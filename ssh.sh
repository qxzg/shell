#!/bin/bash
dnf install -y screen xorg-x11-xauth
echo "GPG_TTY=$(tty)
export GPG_TTY" >> ~/.bashrc
##关闭SELlinux
setenforce 0
cd && sed -i -e "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
#关闭Centos7默认防火墙
systemctl stop firewalld
systemctl disable firewalld
cd && mkdir .ssh
chmod 700 .ssh/
cd .ssh
#配置密钥
wget -O authorized_keys https://raw.githubusercontent.com/qxzg/shell/master/other/authorized_keys
chmod 600 authorized_keys
cd && sed -i -e "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
cd && sed -i -e "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
#更换端口
cd && sed -i -e "s/#Port/Port/g" /etc/ssh/sshd_config
cd && sed -i -e "s/Port 22/Port 8848/g" /etc/ssh/sshd_config
#安全设置
cd && sed -i -e "s/#MaxAuthTries 6/MaxAuthTries 6/g" /etc/ssh/sshd_config
cd && sed -i -e "s/#ClientAliveInterval 0/ClientAliveInterval 900/g" /etc/ssh/sshd_config
cd && sed -i -e "s/#ClientAliveCountMax 3/ClientAliveCountMax 3/g" /etc/ssh/sshd_config
cd && sed -i -e "s/#MaxAuthTries 6/MaxAuthTries 6/g" /etc/ssh/sshd_config
echo "Protocol 2" >> /etc/ssh/sshd_config

service sshd restart
cd .ssh && cat authorized_keys
