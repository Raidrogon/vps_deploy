#!/bin/bash
echo $1 "start port:" $2 "end port:"$3



# sysctl.conf ..............
cat sysctl.conf >> /etc/sysctl.conf

# time...................
sysctl -p
rm -rf /etc/localtime
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

apt install -y unzip
unzip Xray-linux-64.zip
rm -rf Xray-linux-64.zip
chmod +x xray
/usr/bin/wget -v -N  https://github.com/crab21/v2ray-rules-dat/releases/latest/download/geoip.dat -O /root/xray/geoip.dat
/usr/bin/wget -v -N  https://github.com/crab21/v2ray-rules-dat/releases/latest/download/geosite.dat -O /root/xray/geosite.dat
         
# install tools
apt update -y
apt install -y debian-keyring debian-archive-keyring apt-transport-https curl lsb-release
curl -sL 'https://deb.dl.getenvoy.io/public/gpg.8115BA8E629CC074.key' | gpg --dearmor -o /usr/share/keyrings/getenvoy-keyring.gpg
echo a077cb587a1b622e03aa4bf2f3689de14658a9497a9af2c427bba5f4cc3c4723 /usr/share/keyrings/getenvoy-keyring.gpg | sha256sum --check
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/getenvoy-keyring.gpg] https://deb.dl.getenvoy.io/public/deb/debian $(lsb_release -cs) main" |             tee /etc/apt/sources.list.d/getenvoy.list
apt update -y
apt install -y getenvoy-envoy
apt install -y net-tools
apt install -y vnstat vnstati
chmod +x /root/vnstat.sh








# ///////////////////////xray disable and delete
ls /etc/systemd/system | grep xray | xargs systemctl disable --now
rm -rf /etc/systemd/system/xray_*
rm -rf vision/*

# ///////////////////////xray enable
mkdir -p vision

for (( i=${2}; i<=${3}; i++ ))
do
    cat template/example.json | sed 's/domain.imrcrab.com/'${1}'/g' | sed 's/xxxx/'${i}'/g' > vision/xray_${i}.json
    cat template/example.service | sed 's/xxxx/'${i}'/g' > /etc/systemd/system/xray_${i}.service
done

cat template/envoy.yaml | sed 's/domain.imrcrab.com/'${1}'/g'  > envoy_${i}.yaml
cat template/envoy.service > /etc/systemd/system/envoy.service 

# cat ws/xray_ws.service > /etc/systemd/system/xray_ws.service  
# systemctl enable --now envoy.service

systemctl daemon-reload

sleep 1s
ls /etc/systemd/system | grep xray | xargs systemctl enable --now
sleep 2s
ls /etc/systemd/system | grep xray | xargs systemctl restart

sleep 2s




# ///////////////////log disable

chmod +x log.sh
./log.sh


### crontab
cat crontab.md