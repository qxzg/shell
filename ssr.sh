#/bin/bash
cd
wget https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh
chmod +x tcp.sh
cd
systemctl stop firewalld
systemctl disable firewalld
yum -y install ntp zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel gcc git
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -s
hwclock -w
ntpdate cn.pool.ntp.org
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
cat >> ~/.bashrc << EOF
export PATH="/root/.pyenv/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF
source ~/.bashrc
pyenv install 3.7.1
pyenv global 3.7.1
git clone https://github.com/ssrpanel/shadowsocksr.git
mv shadowsocksr/ ssr/
cd ssr
chmod +x *.sh
./setup_cymysql.sh
touch dns.conf
echo "1.1.1.1 53
1.0.0.1 53" >> dns.conf
pip install -r requestment.txt
rm -f run.sh
touch run.sh
echo "#!/bin/bash
/root/.pyenv/shims/python /root/ssr/server.py m >> /root/ssr/ssserver.log 2>&1" >> run.sh
chmod +x run.sh
echo "[Unit]
Description=ssr
Documentation=https://github.com/ssrpanel/shadowsocksr
After=network.target

[Service]
ExecStartPre=eval $(ps -ef | grep "[0-9] python server\\.py m" | awk '{print "kill "$2}')
ExecStart=/root/ssr/run.sh
Restart=always

[Install]
WantedBy=multi-user.target">> /usr/lib/systemd/system/ssr.service
systemctl daemon-reload
systemctl enable ssr
systemctl start ssr
systemctl status ssr
echo "请编辑/root/ssr/usermysql.json内的数据库连接信息"
