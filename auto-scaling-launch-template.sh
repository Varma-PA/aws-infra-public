#!/bin/bash

  cd /home/ec2-user
  touch .env
  echo DB_DATABASE="${db_name}" >> .env
  echo DB_USERNAME="${username}" >> .env
  echo DB_PASSWORD="${password}" >> .env
  echo DB_HOST="${database_address}" >> .env
  echo PORT="3002" >> .env
  echo AWS_S3_BUCKET_NAME="${s3_bucket}" >> .env
  echo NODE_ENV="production" >> .env  

  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/home/ec2-user/cloud-watch-config.json \
    -s

  sudo systemctl daemon-reload
  sudo systemctl enable nginx
  sudo systemctl start nginx
  sudo systemctl enable webapp
  sudo systemctl start webapp