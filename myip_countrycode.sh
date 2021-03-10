#!/bin/sh
# myip_countrycode.sh,
# v1.1 # by pingiy
# This script makes request to wtfismyip.com service, returns ISO 3166-2 country code, ip address of the machine on which it is running,
# (https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)
# writes output (2 characters) to '.ip' file, and returns output that can be added to the xfce panel, to the 'shared monitor' element,
# by adding the command 'sh [/path-to-script/./myip_countrycode.sh]',
# and be sure to set the refresh interval for the 'shared monitor' element, at least 60 seconds,
# otherwise wtfismyip.com can ban your IP, according to the service automation regulations:

# "All we ask is that you limit usage to 1 request per minute, per IP address.
# Any usage in excess of this may lead to a temporary block. "
# (https://wtfismyip.com/automation)

# requires: ping, curl, whois, awk, usage: 'chmod + x myip_countrycode.sh; ./myip_countrycode.sh '

# script path detection, to avoid summon orphaned files in random dir, from where you throw command:
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
# this url return your ip to you:
MYIP=https://wtfismyip.com/text

# do NOT use decimal ip in PING_URL, only domain names, to avoid sript lag.
# if network down, ping MUST return 'name resolution error', then not touch variable,
# to avoid next 'if' fork breakdown.
PING_URL=t.me
FILE=$DIR/.ip

echo %% > $FILE

PING=
PING=$(ping $PING_URL -q -c1 -w3 -W3)
if [[ "$PING" ]]; then
        CURRENT=$(cat $FILE)
        COUNTRY=$(curl $MYIP --silent | xargs whois | awk '/country:/{print $NF; exit}')
        if [[ $COUNTRY != $CURRENT ]]; then
                CURRENT=$COUNTRY
                echo $CURRENT >$FILE;
                echo $COUNTRY
        else
                echo $CURRENT
        fi
else
        echo OFF >$FILE
fi
