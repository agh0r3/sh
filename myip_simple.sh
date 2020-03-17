#!/bin/sh
# короткий скрипт возвращает код страны ip

MYIP=wtfismyip.com/text
URL=t.me
PING=$(ping $URL -q -c1 -w3)
if [ "$PING" ];then
 CODE=$(curl $MYIP --silent |xargs whois |awk '/country:/{print $NF; exit}')
 echo Country: $CODE
else
 echo offline
fi
