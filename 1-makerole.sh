#!/bin/sh -uex
# lamdaで使うroleを作成
# ./0-setenv.sh を実行すると、サブシェルが上がるので、そこで実行すること

aws iam create-role \
  --role-name "$ROLE" \
  --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'
