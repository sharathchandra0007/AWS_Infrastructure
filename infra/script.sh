#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo apt install unzip -y
cd /tmp && wget https://www.free-css.com/assets/files/free-css-templates/download/page295/antique-cafe.zip
unzip /tmp/antique-cafe.zip
sudo mv /tmp/2126_antique_cafe/ /var/www/html/cafe/