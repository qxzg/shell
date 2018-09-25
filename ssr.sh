#/bin/bash
yum -y install ntp git wget unzip
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -s
hwclock -w
ntpdate cn.pool.ntp.org
git clone https://github.com/ssrpanel/shadowsocksr.git /root/ssr
chmod +x /root/ssr/*.sh
/root/ssr/setup_cymysql2.sh
rm -f REL_0_9_4.tar.gz
echo "Down."
