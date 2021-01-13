#!/bin/sh
# myip_countrycode.sh,
# v1.2 #agh0r3@proton mail.com,
# скрипт возвращает ISO 3166-2 код страны, ip адреса машины, на которой запущен,
# (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)
# пишет вывод (2 символа) в файл '.ip', и возвращает вывод который можно выводить в панель xfce, в элемент 'общий монитор',
# добавив команду 'sh [/путь-к-скрипту/./myip_countrycode.sh]',
# и обязательно выставить интервал обновления элемента 'общий монитор', не менее 60 секунд,
# иначе wtfismyip.com может забанить ваш IP, согласно регламенту автоматизации сервиса:

# "All we ask is that you limit usage to 1 request per minute, per IP address.
# Any usage in excess of this may lead to a temporary block."
# (https://wtfismyip.com/automation )

# требует: ping, curl, whois, awk, использование: 'chmod +x myip_countrycode.sh; ./myip_countrycode.sh'

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

PING=
PING=$(ping $PING_URL -q -c1 -w3 -W3)
if [[ "$PING" ]]; then
        CURRENT=$(cat $FILE)
        COUNTRY=$(curl $MYIP --silent | xargs whois | awk '/country:/{print $NF; exit}')
        if [[ $COUNTRY != $CURRENT ]]; then
                CURRENT=$COUNTRY
                echo $CURRENT >$FILE; # echo $VPNSTATUS >$FILE
                echo $COUNTRY
        else
                echo $CURRENT
        fi
else
        echo OFF >$FILE
fi
