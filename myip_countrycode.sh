  GNU nano 4.8                                                                                                                                                                                 myip_countrycode.sh                                                                                                                                                                                          
#!/bin/sh
# myip_countrycode.sh, v1 #agh0r3@proton mail.com,
# скрипт возвращает ISO 3166-2 код страны, ip адреса машины, на которой запущен,
# ( https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements )
# пишет вывод (2 символа) в файл '.ip', который можно выводить в панель xfce,
# в элемент 'общий монитор', добавив команду 'cat /путь-к-скрипту/.ip
# требует: ping, curl, whois, awk, использование: 'chmod +x myip_countrycode.sh; ./myip_countrycode.sh'

# script path detection, to avoid summon orphaned
# files in random dir, from where you throw command:
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
# dis fuckin' url turns your fckn ip to you:
MYIP=wtfismyip.com/text

# do NOT use decimal ip in PINGIN_URL, only domain names, to avoid sript lag.
# if network down, ping MUST return 'name resolution error', then not touch variable,
# to avoid next 'if' fork breakdown.
PINGIN_URL=amazon.com
FILE=$DIR/.ip
touch $FILE
echo script directory: $DIR

while :
do
        PING=
        PING=$(ping $PINGIN_URL -q -c1 -w3 -W3)
        if [ "$PING" ]; then
                CURRENT=$(cat $FILE)
                COUNTRY=$(curl $MYIP --silent | xargs whois | awk '/country:/{print $NF; exit}')
                if [ $COUNTRY != $CURRENT ]; then
                        CURRENT=$COUNTRY
                        echo $CURRENT >$FILE
                        echo your ip country code changed: $COUNTRY
                else
                        echo your ip country code: $CURRENT
                fi
        else
                echo OFF >$FILE; echo Houston, we havent external ip.
        fi

# long random sleep, do not use less than 60 sec interval, because of
# WTFISMYIP.COM Automation Policy:
#  "All we ask is that you limit usage to 1 request per minute, per IP address.
# Any usage in excess of this may lead to a temporary block."
# (https://wtfismyip.com/automation )
sleep $[ ( $RANDOM % 75 ) + 60 ]s

done
