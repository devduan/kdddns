# Kdsoft Godday DDNS

These scripts are used as a daemon service to detect changes of the server's dynamic ip address and update it to the setting of DNS records on Godaddy.

The script will run every 1 minute and compare the server's public ip with which kept as record on Godaddy, if they are different, update the record.

##Contents:
1. ddns.sh
2. kdddns.service
3. README.md

##Configuration:
1. update ddns.sh with your domain, hostname, production key/secrete pair from developer.godaddy.com.
2. update kdddns.service with ddns.sh path.

##Setup
1. sudo chmod +x ddns.sh
2. sudo cp kdddns.service /etc/systemd/system
3. sudo systemctl daemon-reload
4. sudo systemctl enable kdddns
5. sudo systemctl start kdddns 
