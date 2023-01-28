#!/bin/bash

systemctl stop ebpf
systemctl stop ebpf

mv -f ebpf.service /etc/systemd/system/ebpf.service
chmod +x ebpf
cd ../
rm -rf ebpf
mv ebpf_bk ebpf
chmod +x ebpf

systemctl daemon-reload
systemctl enable --now ebpf
systemctl restart ebpf
systemctl disable --now ebpf