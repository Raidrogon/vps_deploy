#!/bin/bash


systemctl disable rsyslog.service

systemctl disable systemd-journald.service
 rm -rf  /var/log/*.log.*
journalctl --vacuum-size=5M
