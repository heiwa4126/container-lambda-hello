#!/bin/sh -uex
# app.pyをlambdaとしてデプロイ
# 1-makerole.shの次に実行

zip package.zip app.py

aws lambda create-function --function-name "$FUNC" \
  --runtime python3.9 \
  --handler app.handler \
  --zip-file fileb://./package.zip \
  --role ${ROLE_ARN}
