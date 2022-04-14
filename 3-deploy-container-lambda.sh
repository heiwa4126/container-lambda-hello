#!/bin/sh -uex
# app.pyをlambdaコンテナとしてデプロイ
# 1-makerole.shの次に実行

docker build -t func1 .

# ECR に今回作成する Lambda 関数のイメージ用のリポジトリを作成
aws ecr create-repository --repository-name func1

# リポジトリの URI を含めたタグを付与
docker tag func1:latest \
  ${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com/func1:latest

# ECR にログイン
aws ecr get-login-password |
  docker login --username AWS --password-stdin ${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com

# リポジトリに push
docker push ${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com/func1:latest

# ダイジェストをDIGEST 環境変数に
DIGEST=$(aws ecr list-images --repository-name func1 \
  --out text --query 'imageIds[?imageTag==`latest`].imageDigest')

# lambda作成
aws lambda create-function \
  --function-name func1-container \
  --package-type Image \
  --code ImageUri=${ACCOUNTID}.dkr.ecr.${REGION}.amazonaws.com/func1@${DIGEST} \
  --role ${ROLE_ARN}

echo "デプロイしてからinvokeできるようになるまで数10秒かかります"
