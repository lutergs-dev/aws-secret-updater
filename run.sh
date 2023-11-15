#!/bin/sh

# create aws credential folder and set aws info
mkdir -p ~/.aws
echo "[default]" > ~/.aws/config
echo "region = $REGION" >> ~/.aws/config
echo "[default]" > ~/.aws/credentials
echo "aws_access_key_id = $ACCESS_KEY" >> ~/.aws/credentials
echo "aws_secret_access_key = $SECRET_KEY" >> ~/.aws/credentials

aws ecr get-login-password --region $REGION > ~/key.txt

chmod 755 kubectl

~/kubectl --kubeconfig=/etc/secret/config create secret docker-registry $SECRET_NAME \
  --docker-server=$REPOSITORY_URL \
  --docker-username=AWS \
  --docker-password=$(cat ~/key.txt) \
  -n $NAMESPACE