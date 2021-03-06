# container-lambda-hello

[コンテナ利用者に捧げる AWS Lambda の新しい開発方式 ! - 変化を求めるデベロッパーを応援するウェブマガジン | AWS](https://aws.amazon.com/jp/builders-flash/202103/new-lambda-container-development/?awsf.filter-name=*all)
を元に作った
コンテナlambdaのサンプル

# いるもの

- AWSのアカウント
- aws cli
- docker


# デプロイ手順

まず `config.sh` を編集する(そのままでもOK)

以下の順で実行
```sh
./0-setenv.sh
./1-makerole.sh
./2-deploy-lambda.sh
./3-deploy-container-lambda.sh
exit
```

# テスト

```sh
./invoke-lambda.sh    # 普通のlambdaを起動
./invoke-container.sh # コンテナ版lambdaを起動
```


# コンテナlambdaの更新

app.pyを修正の後(たとえば!の数を増やしてみる等)
```sh
./0-setenv.sh
./4-update-container.sh
exit
```

単にECR上のイメージを更新しただけじゃダメなのがミソ。


# ローカルのdockerでテスト

```sh
./run_local_docker.sh   # 9090/tcpでlambda起動
./test_local_docker.sh  # 妙なURLでlambdaを呼び出す
./stop_local_docker.sh  # docker停止
```


# 削除

コンソールから
1. lamda2つを消す
1. ECRからコンテナを消す (EKSのところにあり)
1. ロールを消す

たぶんこれでOK。余裕があったらスクリプトにする

他、ローカルのdockerにイメージが残ってるので、
必要に応じて消す。
