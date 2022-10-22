#!/bin/bash
ipnow=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")
echo ${ipnow}
vnstati -s -o /tmp/summary.png

curl -4 -F "chat_id=639130306" \
     -F "caption=\"`hostname`
${ipnow} \"" \
     -F "photo=@/tmp/summary.png" \
     https://api.telegram.org/bot1896867188:AAGD9umD76RWDLpCInqFBfQbQU9BBRlWhZ8/sendPhoto


rm -rf /tmp/summary.png