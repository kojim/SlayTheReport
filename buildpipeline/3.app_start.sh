#!/bin/sh

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 947597759324.dkr.ecr.ap-northeast-1.amazonaws.com
docker image prune -f
docker pull 947597759324.dkr.ecr.ap-northeast-1.amazonaws.com/slaythereport_mountless
cd /home/ubuntu/SlayTheReport/docker && docker-compose -f docker-compose-production.yaml up -d sinatra
