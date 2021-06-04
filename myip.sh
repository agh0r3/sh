#!/bin/bash
# myip.sh,
# v1.2 # by pigiy
# This script makes request to wtfismyip.com service, returns ISO 3166-2 country code, ip address of the machine on which it is running,
# (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)

# script returns output (2 characters) that can be added to the xfce panel, for monitoring your ip address country when you connected over vpn.
# adding the command 'sh [/path-k-script/./myip.sh]', to the 'shared monitor' element in xfce panel.
# and be sure to set the refresh interval for the 'shared monitor' element, at least 60 seconds,
# otherwise wtfismyip.com can ban requests from your IP, according to the service automation regulations:

# "All we ask is that you limit usage to 1 request per minute, per IP address.
# Any usage in excess of this may lead to a temporary block. "
# (https://wtfismyip.com/automation)

# requirements: ping, curl, whois, awk, xfce4-panel, xce4-genmon-plugin
# usage: make script executable: 'chmod + x myip.sh
# and run: ./myip.sh '

MYIP=https://wtfismyip.com/text
PING_URL=wtfismyip.com

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
