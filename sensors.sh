#!/bin/bash
yum -y groupinstall "Development Tools"
cd
wget "https://github.com/lm-sensors/lm-sensors/archive/V3-5-0.tar.gz"
tar zxf V3-5-0.tar.gz
rm -f V3-5-0.tar.gz
cd lm-sensors-3-5-0
make
make install
echo ""
echo -e "安装完成，现在可以使用\033[41;37m msensors \033[0m命令查看系统温度了哟qwq"
