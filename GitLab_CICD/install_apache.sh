#/bin/bash
sudo apt-get install apache2 -y
sudo systemctl start apache2
cp /home/ndomi/Documents/GitLab/my-static-website /var/www/html