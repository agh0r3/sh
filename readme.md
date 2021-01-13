# myip_countrycode.sh, v1.1 #agh0r3@proton mail.com,
# скрипт возвращает ISO 3166-2 код страны, ip адреса машины, на которой запущен,
# ( https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements )
# пишет вывод (2 символа) в файл '.ip', и в терминал. можно выводить в панель xfce, в элемент 'общий монитор',
# добавив команду 'sh [/путь-к-скрипту/./myip_countrycode.sh]',
# и обязательно выставить интервал обновления элемента 'общий монитор' равным не менее 60 секунд, иначе wtfismyip.com может забанить ваш IP !

# "All we ask is that you limit usage to 1 request per minute, per IP address.
# Any usage in excess of this may lead to a temporary block."
# (https://wtfismyip.com/automation )

# требует: ping, curl, whois, awk, sed
# использование: 'chmod +x myip_countrycode.sh; ./myip_countrycode.sh'
