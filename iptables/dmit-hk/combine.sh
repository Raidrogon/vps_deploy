#!/bin/bash

w_ip_path="ip_white"
b_ip_path="ip_black"

cat before.conf > iptables.conf

if [[ -f "${w_ip_path}" ]]; then
      # cat ${w_ip_path} | while read line
      while read line || [[ -n ${line} ]]
      do
        if [[ "${line}" =~ ^\#.* ]] || [[ ! -n ${line} ]];then
            continue
        fi
        echo "-A INPUT -s ${line} -p tcp -m tcp --dport 1443:1500 -j ACCEPT" >> white_iptables.conf
        echo "-A INPUT -s ${line} -p tcp  --match multiport --dports 3306,19092,6379 -j ACCEPT" >> white_iptables.conf
      done < ${w_ip_path}
fi

# echo "-A INPUT -p tcp  --match multiport --dports 3306,19092,6379 -j ACCEPT" >> white_iptables.conf


sort white_iptables.conf | uniq  >> iptables.conf
cat end.conf >> iptables.conf
cp ip_white ip_white.bak

