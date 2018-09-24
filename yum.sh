#!/bin/bash
yum clean all
yum -y update
yum -y install zip unzip screen net-tools bind-utils vim* make gcc gcc-c++ gdb mtr wget curl automake autoconf time perl-Time-HiRes python perl virt-what gdbautomake ntp gnupg
