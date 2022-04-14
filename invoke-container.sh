#!/bin/sh -uex
# deploy.shでデプロイしたcontainer lambdaを実行

. ./config.sh

OUTPUT=/tmp/output2

rm -f "$OUTPUT"
aws lambda invoke --function-name "$FUNCC" "$OUTPUT"
cat "$OUTPUT"
