#!/bin/bash

sudo yum install java -y
sudo yum install git -y
sudo yum install maven -y

if [ -d "addressbook-v1" ]
then
  echo "repo is cloned and exists"
  cd /home/ec2-user/addressbook-v1
  git pull origin b1
else
  git clone https://github.com/PraveenKumarDova/addressbook-v1.git
fi

cd /home/ec2-user/addressbook-v1
mvn clean package
