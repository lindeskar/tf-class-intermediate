#!/bin/bash
yum install epel-release -y
yum install nginx -y
systemctl enable nginx
systemctl start nginx
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --reload
