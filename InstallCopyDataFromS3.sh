#! /bin/bash
# Install Apache
apt-get update -y
apt-get install apache2 -y
systemctl start apache2
systemctl enable apache2

# Install AWScli
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# Rename default Apache default file
mv /var/www/html/index.html /var/www/html/index.old
# Copy index.html from S3
sudo aws s3 cp s3://admin-userdata-content-2729/web/index.html /var/www/html/index.html