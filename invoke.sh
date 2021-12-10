#!/bin/sh -uex
# deploy.shでデプロイしたlambdaを実行

. ./config.sh

aws lambda invoke --function-name "$FUNC" output
cat output
