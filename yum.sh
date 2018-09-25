#!/bin/bash
if [ `whoami` != "root" ];then
        echo "请以账号root运行这个脚本！"
        exit
fi
full=${1}
if [ -z ${full} ] ;then
	echo "   请输入0以最小化安装，输入1以完整安装"
	exit
fi
echo "开始安装！"
sleep 1
yum clean all
yum -y update
yum -y install epel-release
yum -y install zip unzip screen net-tool mtr sbind-utils vim* make wget curl time ntp gnupg rsync xorg-x11-xauth
if [ ${full} = "1" ];then
	yum -y install gcc-c++ gdb automake m2crypto autoconf libsodium perl-Time-HiRes python perl virt-what libmcrypt-devel pv pcre-devel openssl openssl-devel gd bzip2 bzip2-devel libevent-devel libxslt-devel freetype-devel unixODBC-devel aspell-devel readline-devel net-snmp-devel enchant-devel gmp-devel
	yum -y groupinstall "Development Tools"
fi
yum clean all
echo "Down!"

