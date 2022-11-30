#!/bin/bash

port_list=(443 1443 1444 1445 1446 1447 1448 1449 1450)
w_ip_path="ip_white"
b_ip_path="ip_black"

cat before.conf > iptables.conf

if [[ -f "${w_ip_path}" ]]; then
      # cat ${w_ip_path} | while read line
      while read line || [[ -n ${line} ]]
      do
            for ele in ${port_list[@]}
            do 
                  if [[ "${line}" =~ ^\#.* ]] || [[ ! -n ${line} ]];then
                        continue
                  fi
                  echo "-A INPUT -s ${line} -p tcp -m tcp --dport ${ele} -j ACCEPT" >> iptables.conf
            done
      done < ${w_ip_path}
fi


if [[ -f "${b_ip_path}" ]]; then
      while read line || [[ -n ${line} ]]
      do
            for ele in ${port_list[@]}
            do 
                  if [[ "${line}" =~ ^\#.* ]] || [[ ! -n ${line} ]];then
                        continue
                  fi
                  echo "-A INPUT -s ${line} -p tcp -m tcp --dport ${ele} -j DROP" >> iptables.conf
            done
      done < ${b_ip_path}
fi

cat end.conf >> iptables.conf


