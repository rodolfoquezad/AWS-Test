#!/bin/bash

DB_HOST="${db_host}"
DB_USER="raque"
DB_PASS="passw1234"

sudo yum update -y
sudo yum install -y docker

sudo systemctl start docker
sudo systemctl enable docker

sudo aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 160560110095.dkr.ecr.us-east-1.amazonaws.com

sudo docker pull 160560110095.dkr.ecr.us-east-1.amazonaws.com/aws-test:latest

sudo docker run -d \
  -p 80:80 \
  -p 8080:8080 \
  -e DB_HOST=$DB_HOST \
  -e DB_USER=$DB_USER \
  -e DB_PASS=$DB_PASS \
  160560110095.dkr.ecr.us-east-1.amazonaws.com/aws-test:latest
