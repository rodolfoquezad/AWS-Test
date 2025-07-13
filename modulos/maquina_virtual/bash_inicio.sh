#!/bin/bash

sudo yum update -y
sudo yum install -y docker

sudo systemctl start docker
sudo systemctl enable docker

sudo aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 160560110095.dkr.ecr.us-east-1.amazonaws.com/aws-test

sudo docker pull 160560110095.dkr.ecr.us-east-1.amazonaws.com/aws-test:latest

sudo docker run -d \
  -p 80:80 \
  -p 8080:8080 \
  160560110095.dkr.ecr.us-east-1.amazonaws.com/aws-test