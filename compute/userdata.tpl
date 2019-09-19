#!/bin/bash
yum install httpd -y
echo "Server number: ${server_number}" >> /var/www/html/index.html
service httpd start
chkconfig httpd on
