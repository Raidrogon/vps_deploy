#!/bin/bash

vnstati -s -o /tmp/summary.png

curl -4 -F "chat_id=639130306" \
     -F "caption=\"`hostname`\"" \
     -F "photo=@/tmp/summary.png" \
     https://api.telegram.org/bot1896867188:AAGD9umD76RWDLpCInqFBfQbQU9BBRlWhZ8/sendPhoto


rm -rf /tmp/summary.png
