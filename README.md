## yum.sh

- 脚本说明: 一键更新yum源以及安装常用包
- 使用./yum 0安装基本包，使用./yum 1安装完整包

#### 下载安装:
``` bash
wget https://raw.githubusercontent.com/qxzg/shell/master/yum.sh && chmod +x yum.sh
```
## ssh.sh(警告：这个脚本包含了我的个人ssh公钥，如直接使用会导致你的ssh无法登录！！)

- 部署ssh公钥登录
- 更改默认22端口至8848
- 增加一些SSH的安全配置

#### 下载安装:
``` bash
wget https://raw.githubusercontent.com/qxzg/shell/master/ssh.sh && chmod +x ssh.sh && ./ssh.sh && rm -f ssh.sh
```

## noaliyun.sh

- 一键卸载所有套路云的监控软件

#### 下载安装:
``` bash
wget https://raw.githubusercontent.com/qxzg/shell/master/noaliyun.sh && chmod +x noaliyun.sh && ./noaliyun.sh && rm -f noaliyun.sh
```
