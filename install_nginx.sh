#!/bin/bash
dnf update -y
dnf install -y nginx

systemctl start nginx
systemctl enable nginx

echo "<h1>Server is running on $(hostname -f)</h1>" > /usr/share/nginx/html/index.html
