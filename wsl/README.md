# wsl

WSLでDockerによるビルド・デバッグ開発環境を作成するためのサンプル

## WSLおよび仮想OSのインストール

PowerShellを管理者権限で起動し、以下のコマンドを実行する。

``` powershell
# インストールできる仮想OS一覧を表示する
PS> wsl --list --online
# WSLおよび仮想OSのインストール
PS> wsl --install -d <DistroName>
# 「Installing, this may take a few minutes...」が表示される
# 以降、案内に従ってユーザー名とパスワードを設定する
# 設定後に自動ログインするため、一度ログアウトする
$ exit
# ログインする
PS> wsl
# 必要なパッケージをインストールする
$ apt install git
# 本リポジトリをダウンロードする
$ git clone http://github.com/rotace/sample_docker
$ cd sample_docker
```

次回以降は、以下の方法より仮想OSを入手することも可能である。
* MicrosoftStoreから入手する。
* [ダウンロードサイト](https://learn.microsoft.com/ja-jp/windows/wsl/install-manual#downloading-distributions)から入手して[手動インストール](https://min117.hatenablog.com/entry/2020/04/06/232908)する。

## Dockerのセットアップ

仮想OSを起動し、[公式ページ](https://docs.docker.com/engine/install/ubuntu/)の通り以下のコマンドを実行する。

``` bash
# 事前準備
$ sudo apt update
$ sudo apt remove docker docker-engine docker.io containerd runc
# 周辺ライブラリのインストール
$ sudo apt install ca-certificates curl gnupg lsb-release
# 公式リポジトリの登録
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# Dockerのインストール
$ sudo apt update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
# Dockerエンジンの起動
$ sudo service docker start
# 確認
$ sudo docker run --rm hello-world
```

## Dockerグループにユーザを追加

以下のコマンドを実行する。

``` bash
$ sudo gpasswd -a $USER docker
$ sudo service docker restart
$ exit
# 再ログインしてsudoなしでdockerコマンドを確認
$ docker run --rm hello-world
```

## C言語開発用のコンテナの準備

以下のコマンドを実行する。
実行後はログインした状態のままにしておく。

``` bash
# コンテナ起動
$ docker run --rm -it -w /work -v "${PWD}":/work debian:bullseye-slim bash
# パッケージのインストール
(/work) apt update
(/work) apt install -y build-essential git gdb
(/work) apt clean
# C言語アプリのビルド
(/work) cd wsl
(/work/wsl) gcc hoge.c -o hoge
# C言語アプリの実行
(/work/wsl) ./hoge
```

## VSCodeのセットアップ

1. VSCodeをインストールする。
1. VSCodeの拡張機能である「Remote Development」をローカルにインストールする。
1. ［WSLへ接続］左下の［><］ボタンを押下し、「新しいWSLウィンドウ」を選ぶ。
1. ［コンテナへ接続］左下の［><］ボタンを押下し、「Attach to Running Container」を選ぶ。
1. VSCodeの拡張機能である「C/C++ Extension Pack」をコンテナにインストールする。
1. ```hoge.c```を開き、ブレイクポイントをセットする。
1. 「実行とデバッグ」から「アクティブファイルのビルドとデバッグ」を選択する。


## Reference

* [WSL2のインストールを分かりやすく解説](https://chigusa-web.com/blog/wsl2-win11/)
* [Docker Desktop for Windowsを使わず、WSL2/UbuntuにaptでDockerを入れる](https://sabakunotabito.hatenablog.com/entry/2021/10/03/024348#Ubuntu-%E7%89%88-Docker-%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
* [Dockerコマンドをsudoなしで実行する方法](https://qiita.com/DQNEO/items/da5df074c48b012152ee)
* [C言語開発環境をDocker+VSCodeで構築する](https://qiita.com/suzuki_sh/items/c78627936d46f0108b10)
* [コンテナでC言語の開発環境を構築する](https://qiita.com/Be-cricket/items/0d6da899045a1cbab3ea)