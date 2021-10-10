#!/bin/bash

mydomain="your.domain"
myhostname="your_host_name_on_the_record"
gdapikey="your_godaddy_product_key:product_secret"
log=/your/godaddy/ddns/logname

while : ;
do
sleep 1m

myip=`curl -s "https://api.ipify.org"`

dnsdata=`curl -s -X GET -H "Authorization: sso-key ${gdapikey}" "https://api.godaddy.com/v1/domains/${mydomain}/records/A/${myhostname}"`
gdip=`echo $dnsdata | cut -d ',' -f 1 | tr -d '"' | cut -d ":" -f 2`
#echo "`date '+%Y-%m-%d %H:%M:%S'` - Current External IP is $myip, GoDaddy DNS IP is $gdip" >> $log

if [ "$gdip" != "$myip" -a "$myip" != "" ]; then
  echo "`date '+%Y-%m-%d %H:%M:%S'` - External IP is $myip, GoDaddy DNS IP is $gdip" >> $log
  curl -s -X PUT "https://api.godaddy.com/v1/domains/${mydomain}/records/A/${myhostname}" -H "Authorization: sso-key ${gdapikey}" -H "Content-Type: application/json" -d "[{\"data\": \"${myip}\"}]"
  echo "...Changed IP on ${myhostname}.${mydomain} from ${gdip} to ${myip}" >> $log
fi
done
