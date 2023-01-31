

```
  tc qdisc add dev eth0 root handle 1: htb default 1
  tc qdisc show dev eth0
  tc class add dev eth0 parent 1: classid 1:1 htb rate 600mbps
  tc class add dev eth0 parent 1:1 classid 1:2 htb rate 300Mbit ceil 500Mbit prio 1
  tc class add dev eth0 parent 1:1 classid 1:3 htb rate 300Mbit ceil 500Mbit prio 1
  tc filter add dev eth0 parent 1:0 prio 1 protocol ip handle 2 fw flowid 1:2
  tc filter add dev eth0 parent 1:0 prio 1 protocol ip handle 3 fw flowid 1:3
  iptables -A OUTPUT -t mangle -p tcp --sport 1443:1450 -j MARK --set-mark 2
```