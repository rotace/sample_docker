# sample_docker
Dockerのサンプルコマンド集


| フォルダ名／ファイル名 | 内容 |
| --- | --- |
| 3step_tutorial | 3ステップのチュートリアル |
| gitlab | Gitlabとの連携環境構築サンプル |
| offline | オフライン環境構築サンプル |
| python | Python単体テストサンプル |
| .gitlab-ci.yml | 「Gitlabとの連携環境構築サンプル」で使用するGitlab CI/CDの設定ファイル |
| Doxyfile | Doxygenの設定ファイル |
| Makefile | Dockerの基本コマンドを集めたコマンド集 |

## 基本コマンド

### 一時起動コマンド

一時的に起動するようなコンテナ（python等）を実行したい場合は以下のコマンドを使用する。

``` bash
# 基本
sudo docker run --rm -it alpine:latest pwd # カレントパス表示
sudo docker run --rm -it alpine:latest ls # カレントディレクトリ一覧
sudo docker run --rm -it alpine:latest ls dev/ # コマンド引数も可
sudo docker run --rm -it alpine:latest ash # シェルでログイン
# 応用
sudo docker run --rm -it -w /dev alpine:latest pwd
sudo docker run --rm -it -w /dev alpine:latest ls
sudo docker run --rm -it -w /dev alpine:latest ash
sudo docker run --rm -it -w /output -v tmp:/output alpine:latest pwd
sudo docker run --rm -it -w /output -v tmp:/output alpine:latest ls
sudo docker run --rm -it -w /output -v tmp:/output alpine:latest ash
sudo docker run --rm -it -w /output -v "${PWD}":/output alpine:latest pwd
sudo docker run --rm -it -w /output -v "${PWD}":/output alpine:latest ls
sudo docker run --rm -it -w /output -v "${PWD}":/output alpine:latest ash
```

| コマンドオプション | 概要 |
| --- | --- |
| --rm | コンテナの停止時に自動的にコンテナを削除する |
| -it | 標準入出力をコンテナに結び付ける |
| -w | コンテナ内のカレントディレクトリを指定する |
| -v xxx:/yyy | /var/lib/docker/volumesにボリュームを作成し、コンテナ内で使用する |
| -v "xxx":/yyy | 指定したパスをコンテナ内で使用する |

### 常時起動コマンド

常時起動するようなコンテナ（WEBサーバ等）を実行したい場合は以下のコマンドを使用する。

``` bash
# 基本
sudo docker run -d --name tmp httpd:latest
# 応用
sudo docker run -d --name tmp --restart always httpd:latest
sudo docker run -d --name tmp --restart always -p 80:80 httpd:latest
sudo docker run -d --name tmp --restart always -p 80:80 -v web_data:/usr/local/apache2/htdocs httpd:latest
# コンテナに対してログイン
sudo docker exec -it tmp /bin/bash
# コンテナを一時停止
sudo docker stop tmp
# コンテナを削除
sudo docker rm tmp
# オプション比較
sudo docker run --rm httpd:latest # フォアグランドでhttpdを実行
sudo docker run --rm -it httpd:latest /bin/bash # 別プロセスでbashを実行する
sudo docker run --rm -d --name tmp httpd:latest # バックグラウンドでhttpdを実行
sudo docker run stop httpd:latest # httpdを停止（--rmオプションによりコンテナは削除）
```

| コマンドオプション | 概要 |
| --- | --- |
| -d | コンテナをバックグラウンドで起動する |
| --name | コンテナ名を明示的に指定する |
| --restart | ホストOSの起動時にコンテナを再起動する |
| -p xx:yy | コンテナ側ポートyyをホスト側ポートxxに公開する |
| -p xx-xxx:yy-yyy | コンテナ側ポートyy-yyyをホスト側ポートxx-xxxに公開する |
| -v xxx:/yyy | /var/lib/docker/volumesにボリュームを作成し、コンテナ内で使用する |

## C言語 開発例

Dockerを使ったC言語の開発例を以下に示す。

``` bash
# カレントディレクトリをバインドしてコンテナ起動
sudo docker run --rm -it -w /work -v "${PWD}":/work alpine:latest ash
# 必要なパッケージをインストール
(/work) apk add --no-cache gcc libc-dev
# 実行
(/work) gcc --version
# ログアウト
(/work) exit
```

## Python 開発例

Dockerを使ったPythonの開発例を以下に示す。

``` bash
# カレントディレクトリをバインドしてコンテナ起動
sudo docker run --rm -it -w /work -v "${PWD}":/work python:3-alpine ash
# 必要なモジュールをインストール
(/work) pip install pytest pytest-cov
# 実行
(/work) pytest
# ログアウト
(/work) exit
```


## ショートカットコマンド一覧

makeコマンドによるショートカットを以下に示す。

| makeコマンド | 操作内容 |
| --- | --- |
| make web.setup | WEBサーバを起動する |
| make web.clean | WEBサーバをシャットダウンする |
| make doc.create | ドキュメントを生成する |
| make doc.deploy | WEBサーバへデプロイする |
| make doc.clean | 生成したドキュメントを削除する |

## Reference

* [Docker ドキュメント日本語化プロジェクト](https://docs.docker.jp/)
* [Docker入門（第六回）〜Docker Compose〜](https://knowledge.sakura.ad.jp/16862/)
* [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)
* [GitLab CIとは？GitLab上でユニットテストを自動化する方法](https://techblog.nhn-techorus.com/archives/12531)
* [dockerを利用したdoxygenの導入](https://qiita.com/hyt-sasaki/items/8f8312e277d1a4815ab6)
