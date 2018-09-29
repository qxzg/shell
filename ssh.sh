#!/bin/bash
#mkdir /root/.ssh
#touch /root/.ssh/authorized_keys
#echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLlqXKKct/TIrPL53AGz9EQVyI0pvPor3r/v/Vrefm7iwQaUrVMgbFVX3Isk9Do9oaEcOtjP2gt2SUtYZJZyneR63FTAwC5ioKm8bU4ROHHOf34i05wL8XvYWVTlZ7mDNwj8tFzaEa+muAifOdgUPO2FSjV2GdhYz4l266RTEyNKYOXeBeTHwgde5qJLf6wxZ03soyCGId0B0MzI8WDExicFPQfmM7KPXZAVtm61ca85hF/lSYLxS4mh9iW3gvRPuP1zHV4j1puKF7fvv2pj6gFs1eH+2s5oUoqfVgYGJ7NwoyojAS7D3aF6ldIleECvwnB3SsJdK2NOO141loxZdh root@qxzg" >> /root/.ssh/authorized_keys
#chmod 700 /root/.ssh
#chmod 600 /root/.ssh/authorized_keys
sed -i -e "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/g" -i -e "s/PasswordAuthentication yes/PasswordAuthentication no/g" -i -e "s/#PermitRootLogin yes/PermitRootLogin yes/g" -i -e "s/Port 22/Port 10086/g" -i -e "s/#Port 22/Port 10086/g" sshd_config
echo "RSAAuthentication yes" >> sshd_config
service sshd restart
