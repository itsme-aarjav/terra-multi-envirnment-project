#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update -y
apt-get install -y nginx

systemctl start nginx
systemctl enable nginx

echo "<h1>Server is running on $(hostname -f)</h1>" > /var/www/html/index.html
