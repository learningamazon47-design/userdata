#! /bin/bash
# Install Apache
echo "----------Installing Apache----------"
apt-get update -y
apt-get install apache2 -y
systemctl start apache2
systemctl enable apache2

# Install AWScli
echo "----------Installing unzip----------"
sudo apt install unzip
echo "----------Downloading and Installing AWS CLI----------"
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# Rename default Apache index file
echo "----------Renaming default Apache index file----------"
mv /var/www/html/index.html /var/www/html/index.old

# Get github PAT from AWS SM
echo "----------Accessing AWS Secrets Manager----------"
GITHUB_PAT=$(sudo aws secretsmanager get-secret-value --secret-id 'githubpat' --region us-west-1 --query 'SecretString' --output text)
echo $GITHUB_PAT

#Get the file from Github
echo "----------Downloading file form GitHub----------"
curl -L -H "Authorization: Bearer $GITHUB_PAT" -H "Accept: application/vnd.github.v3.raw" -o /var/www/html/index.html "https://api.github.com/repos/learningamazon47-design/web/contents/index.html?ref=dev"