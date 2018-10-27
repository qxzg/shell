#/bin/bash
yum -y install ntp git wget
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -s
hwclock -w
ntpdate cn.pool.ntp.org
cd
#wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh
git clone https://github.com/ssrpanel/shadowsocksr.git /root/ssr
cd /root/ssr
chmod +x *.sh
./setup_cymysql2.sh
touch dns.conf
echo "1.1.1.1 53
1.0.0.1 53" >> dns.conf
chmod +x /etc/rc.d/rc.local
echo "/root/ssr/logrun.sh" >> /etc/rc.d/rc.local
systemctl stop firewalld
systemctl disable firewalld
echo "请编辑/root/ssr/usermysql.json内的数据库连接信息"
