#!/bin/sh

# create aws credential folder and set aws info
mkdir -p /root/.aws
echo "[default]" > /root/.aws/config
echo "region = $REGION" >> /root/.aws/config
echo "[default]" > /root/.aws/credentials
echo "aws_access_key_id = $ACCESS_KEY" >> /root/.aws/credentials
echo "aws_secret_access_key = $SECRET_KEY" >> /root/.aws/credentials

aws ecr get-login-password --region $REGION > /root/key.txt

/root/kubectl --kubeconfig=/etc/secret/config delete secret $SECRET_NAME \
  -n $NAMESPACE
/root/kubectl --kubeconfig=/etc/secret/config create secret docker-registry $SECRET_NAME \
  --docker-server=$REPOSITORY_URL \
  --docker-username=AWS \
  --docker-password=$(cat /root/key.txt) \
  -n $NAMESPACE