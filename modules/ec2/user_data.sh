#!/bin/bash
yum update -y
yum install -y httpd php php-mysqlnd wget unzip
systemctl enable httpd
systemctl start httpd

# Install WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html/
chown -R apache:apache /var/www/html
systemctl restart httpd
