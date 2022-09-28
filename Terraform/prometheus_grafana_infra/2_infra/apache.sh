#! /bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
# echo '<h1>Welcome to StackSimplify - APP-1</h1>' | sudo tee /var/www/html/index.html
# mkdir /var/www/html/app1
# sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);">' <h1>Welcome to Stack Simplify - APP-1</h1> <p>Application Version: V1</p></body></html> | sudo tee /var/www/html/app1/index.html
# sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app1/metadata.html

# Installing SSM
cd /tmp
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent