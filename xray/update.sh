#!/bin/bash
version=1.6.5
if [[ -n $1  ]];then
    version=$1
fi
wget -v https://github.com/XTLS/Xray-core/releases/download/${version}/Xray-linux-64.zip
unzip -o Xray-linux-64.zip
chmod +x xray
sleep 2s
ls /etc/systemd/system | grep xray | xargs systemctl restart

sleep 2s