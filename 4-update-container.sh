#!/bin/sh -uex
# app.pyをlambdaコンテナとしてデプロイ
# 3-deploy-container-lambda.sh以降に実行

# イメージ作り直し
docker build -t func1 .

# リポジトリの URI
URI="${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com"

# リポジトリの URI を含めたタグを付与
docker tag func1:latest "$URI/func1:latest"

# ECR にログイン
aws ecr get-login-password |
  docker login --username AWS --password-stdin "$URI"

# リポジトリに push
docker push "$URI/func1:latest"

##-- ここまでだと、lambdaは更新されない

# ダイジェストをDIGEST 環境変数に
DIGEST=$(aws ecr list-images --repository-name func1 \
  --out text --query 'imageIds[?imageTag==`latest`].imageDigest')

# lambda更新
aws lambda update-function-code \
  --function-name "$FUNCC" \
  --image-uri "$URI/func1@${DIGEST}"

echo "invokeできるようになるまで数10秒かかります"
