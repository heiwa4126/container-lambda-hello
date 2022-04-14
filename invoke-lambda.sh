#!/bin/sh -uex
# deploy.shでデプロイしたlambdaを実行

. ./config.sh

OUTPUT=/tmp/output1

rm -f "$OUTPUT"
aws lambda invoke --function-name "$FUNC" "$OUTPUT"
cat "$OUTPUT"
