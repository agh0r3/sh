#!/bin/sh
# myip.sh,
# v1.2 #agh0r3@proton mail.com,
# скрипт возвращает ISO 3166-2 код страны, ip адреса машины, на которой запущен,
# (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)

# пишет вывод (2 символа) который можно выводить в панель xfce, для мониторинга вашего айпи, в элемент 'общий монитор',
# добавив команду 'sh [/путь-к-скрипту/./myip_countrycode.sh]',
# и обязательно выставить интервал обновления элемента 'общий монитор', не менее 60 секунд,
# иначе wtfismyip.com может забанить запросы от вашего IP, согласно регламенту автоматизации сервиса:

# "All we ask is that you limit usage to 1 request per minute, per IP address.
# Any usage in excess of this may lead to a temporary block."
# (https://wtfismyip.com/automation )

# требует: ping, curl, whois, awk, использование: 'chmod +x myip_countrycode.sh; ./myip_countrycode.sh'

MYIP=https://wtfismyip.com/text
PING_URL=t.me

PING=
PING=$(ping $PING_URL -q -c1 -w3 -W3)
if [[ "$PING" ]]; then
        COUNTRY=$(curl $MYIP --silent | xargs whois | awk '/country:/{print $NF; exit}')
        if [[ $COUNTRY ]]; then
                echo $COUNTRY
        else
                echo 'ip'
        fi
else
        echo 'ip'
fi
