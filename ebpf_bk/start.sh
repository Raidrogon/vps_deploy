#!/bin/bash

systemctl stop ebpf
systemctl stop ebpf

mv -f ebpf.service /etc/systemd/system/ebpf.service
wget https://raw.githubusercontent.com/crab21/vps_deploy/main/bin/ebpf -O ebpf
chmod +x ebpf
cd ../
rm -rf ebpf
mv ebpf_bk ebpf
chmod +x ebpf

systemctl daemon-reload
systemctl enable --now ebpf
systemctl restart ebpf