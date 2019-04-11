#!/bin/sh

sudo yum update -y
sudo yum install nginx -y
sudo yum install php -y
sudo systemctl start nginx
sudo systemctl enable nginx
cd /var/www/html
cat > index.php <<- "EOF"
<?php
echo "Hello autointelli";
?>
EOF
sudo useradd remoteuser