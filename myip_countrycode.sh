#!/bin/sh
# myip_countrycode.sh, v1.1 #agh0r3@proton mail.com,
# скрипт возвращает ISO 3166-2 код страны, ip адреса машины, на которой запущен,
# ( https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements )
# пишет вывод (2 символа) в файл '.ip', который можно выводить в панель xfce,
# в элемент 'общий монитор', добавив команду 'cat /путь-к-скрипту/.ip
# требует: ping, curl, whois, awk, sed использование: 'chmod +x myip_countrycode.sh; ./myip_countrycode.sh'

# script path detection, to avoid summon orphaned files in random dir, from where you throw command:
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
# this url return your ip to you:
MYIP=https://wtfismyip.com/text
# NordVPN site
#NORD=https://nordvpn.com/

# do NOT use decimal ip in PING_URL, only domain names, to avoid sript lag.
# if network down, ping MUST return 'name resolution error', then not touch variable,
# to avoid next 'if' fork breakdown.
PING_URL=amazon.com
FILE=$DIR/.ip

echo %% > $FILE
echo script directory: $DIR

while :
do
        PING=
        PING=$(ping $PING_URL -q -c1 -w3 -W3)
        if [[ "$PING" ]]; then
                CURRENT=$(cat $FILE)
                COUNTRY=$(curl $MYIP --silent | xargs whois | awk '/country:/{print $NF; exit}')
                if [[ $COUNTRY != $CURRENT ]]; then
                        CURRENT=$COUNTRY
                        #VPNSTATUS=$(curl -s -N "$NORD" |sed '209!d' |cut -d" " -f1)
                        echo $CURRENT >$FILE; # echo $VPNSTATUS >$FILE
                        echo your ip country code: $COUNTRY
                else
                        echo your ip country code: $CURRENT
                fi
        else
                echo OFF >$FILE; echo Houston, we haven\'t external ip.
        fi

# long random sleep, do not use less than 60 sec interval, because of
# WTFISMYIP.COM Automation Policy:
#  "All we ask is that you limit usage to 1 request per minute, per IP address.
# Any usage in excess of this may lead to a temporary block."
# (https://wtfismyip.com/automation )
sleep $[ ( $RANDOM % 75 ) + 55 ]s
done
