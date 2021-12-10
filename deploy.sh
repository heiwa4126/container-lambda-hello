#!/bin/sh -uex
# app.pyをlambdaとしてデプロイ

. ./config.sh

REGION=$(aws configure get region)
ACCOUNTID=$(aws sts get-caller-identity --output text --query Account)

zip package.zip app.py

aws iam create-role \
    --role-name "$ROLE" \
    --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

ROLE_ARN="arn:aws:iam::${ACCOUNTID}:role/$ROLE"

sleep 10

aws lambda create-function --function-name "$FUNC" \
    --runtime python3.8 \
    --handler app.handler \
    --zip-file fileb://./package.zip \
    --role ${ROLE_ARN}
