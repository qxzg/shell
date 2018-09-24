#!/bin/bash
if [ `whoami` = "root" ];then
	echo "开始安装！"
	yum clean all#先清空yum缓存
	yum -y update#升级yum源
	yum -y install zip unzip screen net-tools bind-utils vim* make gcc gcc-c++ gdb mtr wget curl automake autoconf time perl-Time-HiRes python perl virt-what gdbautomake ntp gnupg#安装软件
	yum clean all
	echo "Down!"
else
	echo "请以账号root运行这个脚本！"
	exit
fi
