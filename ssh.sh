#!/bin/bash
yum install -y screen
cd && mkdir .ssh
chmod 700 .ssh/
cd .ssh
echo "" > authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLlqXKKct/TIrPL53AGz9EQVyI0pvPor3r/v/Vrefm7iwQaUrVMgbFVX3Isk9Do9oaEcOtjP2gt2SUtYZJZyneR63FTAwC5ioKm8bU4ROHHOf34i05wL8XvYWVTlZ7mDNwj8tFzaEa+muAifOdgUPO2FSjV2GdhYz4l266RTEyNKYOXeBeTHwgde5qJLf6wxZ03soyCGId0B0MzI8WDExicFPQfmM7KPXZAVtm61ca85hF/lSYLxS4mh9iW3gvRPuP1zHV4j1puKF7fvv2pj6gFs1eH+2s5oUoqfVgYGJ7NwoyojAS7D3aF6ldIleECvwnB3SsJdK2NOO141loxZdh root@qxzg' > authorized_keys
chmod 600 authorized_keys
cd && sed -i -e "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" /etc/ssh/sshd_config
cd && sed -i -e "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
cd && sed -i -e "s/#Port/Port/g" /etc/ssh/sshd_config
cd && sed -i -e "s/Port 22/Port 10086/g" /etc/ssh/sshd_config
##关闭SELlinux
setenforce 0
cd && sed -i -e "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
service sshd restart
cd .ssh && cat authorized_keys
