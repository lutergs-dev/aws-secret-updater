#!/bin/sh

# activate python virtualenv to use aws-cli
. /python-venv/bin/activate

DOCKER_PASSWORD=$(aws ecr get-login-password --region "$AWS_DEFAULT_REGION")
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

IFS=','
for ns in $NAMESPACES
do
    kubectl $KUBECTL_CONFIG delete secret "$SECRET_NAME" \
      -n "$ns"
    kubectl $KUBECTL_CONFIG create secret docker-registry "$SECRET_NAME" \
      --docker-server="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com" \
      --docker-username=AWS \
      --docker-password="$DOCKER_PASSWORD" \
      -n "$ns"
done
