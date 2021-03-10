# myip.sh
This script makes request to wtfismyip.com service, returns ISO 3166-2 ip address country code of the machine on which it is running,
(https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2#Officially_assigned_code_elements)

script returns output (2 characters) that can be added to the xfce panel, for monitoring your ip address country when you connected over vpn, by adding the command 'sh [/path-to-script/./myip.sh]', to the 'shared monitor' element in xfce panel.

Be sure to set the refresh interval for the 'shared monitor' element, at least 60 seconds, otherwise wtfismyip.com can ban requests from your IP, according to the service automation regulations:

"All we ask is that you limit usage to 1 request per minute, per IP address.
Any usage in excess of this may lead to a temporary block. "
(https://wtfismyip.com/automation)

requires: ping, curl, whois, awk,
usage: make script executable: 'chmod + x myip.sh
and run: ./myip.sh '
