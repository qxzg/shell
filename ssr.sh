#/bin/bash
yum -y install ntp zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel gcc
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -s
hwclock -w
ntpdate cn.pool.ntp.org
cd
#wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh
git clone https://github.com/ssrpanel/shadowsocksr.git
mv shadowsocksr/ ssr/
cd ssr
chmod +x *.sh
./setup_cymysql2.sh
touch dns.conf
echo "1.1.1.1 53
1.0.0.1 53" >> dns.conf
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
cat >> ~/.bashrc << EOF
export PATH="/root/.pyenv/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF
source ~/.bashrc
pyenv install 3.7.1
pyenv global 3.7.1
pip install -r requestment.txt
systemctl stop firewalld
systemctl disable firewalld
echo "请编辑/root/ssr/usermysql.json内的数据库连接信息"
