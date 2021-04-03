#!/bin/sh
trstat=$(curl -I -m 10 -o /dev/null -s -w %{http_code} http://192.168.1.102:9091/)
if [ $trstat -eq 403 ]; then
        service transmission restart
        echo "restart tr"
else
        echo "Is Okey"
fi