#/bin/bash
yum -y install ntp git wget
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -s
hwclock -w
ntpdate cn.pool.ntp.org
git clone https://github.com/ssrpanel/shadowsocksr.git /root/ssr
chmod +x /root/ssr/*.sh
/root/ssr/setup_cymysql2.sh
rm -f REL_0_9_4.tar.gz
touch /root/ssr/dns.conf
echo "1.1.1.1 53
1.0.0.1 53" >> /root/ssr/dns.conf
chmod +x /etc/rc.d/rc.local
echo "/root/ssr/logrun.sh" >> /etc/rc.d/rc.local
echo "成功添加开机自启动"
echo "请编辑/root/ssr/usermysql.json内的数据库连接信息"
