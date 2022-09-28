#! /bin/bash
sudo yum update -y
wget https://github.com/prometheus/prometheus/releases/download/v2.13.0/prometheus-2.13.0.linux-amd64.tar.gz
tar -xf prometheus-2.13.0.linux-amd64.tar.gz
mv prometheus-2.13.0.linux-amd64 /usr/local/
ln -s /usr/local/prometheus-2.13.0.linux-amd64/ /usr/local/prometheus