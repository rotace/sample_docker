# Gitlab
Gitlabとの連携環境構築サンプル

## Requirement

* [Virtualbox 6.1 or above](https://www.virtualbox.org/)
* [Gitlab CE packaged by bitnami 11.7.0](https://bitnami.com/stack/gitlab)
* [Ubuntu Server 20.04.5 LTS](https://releases.ubuntu.com/focal/)

## Network

VirtualboxのNATネットワークを使用する

| Host | IP  | WEB | 備考 |
| ---- | --- | --- | --- |
| router | 10.0.11.1 | - | Virtualboxのデフォルト |
| host | 10.0.11.2 | - | Virtualboxのデフォルト | 
| dhcp | 10.0.11.3 | - | Virtualboxのデフォルト | 
| gitlab-server | 10.0.11.11 | gitlab-server.com | 起動順序１ |
| docker-server | 10.0.11.12 | docker-server.com | 起動順序２ |

## Port-Forwarding

| Host | Service | Port Forwarding | 備考 |
| ---- | ------- | --- | --- |
| gitlab-server | SSH | localhost:11022 -> 10.0.11.11:22 |
| gitlab-server | HTTPS | localhost:11443 -> 10.0.11.11:443 |
| docker-server | SSH | localhost:12022 -> 10.0.11.12:22 |
| docker-server | HTTP | localhost:12080 -> 10.0.11.12:80 |
| docker-server | HTTPS | localhost:12443 -> 10.0.11.12:443 |
| tmp | HTTPS | localhost:14443 -> 10.0.11.4:443 | 初回接続用 |

## Virtualbox

1. virtualboxをダウンロードしてインストール
1. Virtualbox「ファイル」―「環境設定」―「ネットワーク」にNATネットワーク「DockerNetwork」を新規作成
1. 「DHCPのサポート」にチェックを入れる
1. 「ポートフォワーディング」に[ポート設定](#Port-Forwarding)を追加

## Gitlab Server / Setup

1. bitnamiからGitLabCE仮想マシンファイル(.ova)をダウンロード
1. Virtualbox「ファイル」―「仮想アプライアンスのインポート」でovaファイルをインポート
1. Virtualbox「設定」―「一般」で名前を「gitlab-server」に設定
1. Virtualbox「設定」―「ネットワーク」で「NATネットワーク」から「DockerNetwork」を選択
1. gitlab-serverを起動して、ユーザ、パスワード名がコンソールに表示されるまでしばらく待つ
1. 表示されたrootのパスワードとbitnamiのパスワードを記録する
1. 記録したbitnamiのパスワードでログインする
1. 下表に示したbitnamiのパスワードに変更する
1. ホストOSのブラウザから「https://localhost:14443」にアクセスする
1. 記録したrootのパスワードでログインする
1. 下表に示したrootのパスワードに変更する
1. 下表に示したguestのアカウントを作成する

| Service | User | Password |
| ---- | ------- | --- |
| OS User | root | administrator |
| OS User | bitnami | administrator |
| Gitlab User | root | administrator |
| Gitlab User | guest | administrator |

## Gitlab Server / IP Setting

1. ホストOSのコマンドプロンプトからbitnamiでログインする
1. [Configure a static IP address](https://docs.bitnami.com/virtual-machine/faq/configuration/configure-static-address/)を参考に、以下のコマンドでIPアドレスを設定する。
1. 再起動する

``` bash
# NIC名を確認
sudo ifconfig
# 設定ファイルを作成
cd /etc/systemd/network/
sudo cp 99-dhcp.network 25-wired.network
# 設定ファイルを編集
sudo vim 25-wired.network
# 再起動
sudo reboot now
```

設定例を以下に示す。

``` txt
[Match]
Name=enp0s3

[Network]
Address=10.0.11.11
Gateway=10.0.1.1
```

## Gitlab Server / SSH Setting

1. ゲストOSのコンソールからbitnamiでログインする
1. [Bitnami:Activate The SSH Server](https://docs.bitnami.com/virtual-machine/faq/get-started/enable-ssh/)を参考に、以下のコマンドでSSHを有効にする
1. ホストOSのコマンドプロンプトから、`ssh -p 11022 bitnami@localhost`でSSHログインする

``` bash
# 英語キーボードに注意。アンダーバーは[SHIFT]+[=]
sudo rm -f /etc/ssh/sshd_not_to_be_run
sudo systemctl enable ssh
sudo systemctl start ssh
```

## Gitlab Server / DNS Install

1. ホストOSのコマンドプロンプトからbitnamiでログインする
1. 以下のコマンドを実行してDNSをインストールする

``` bash
sudo apt update
sudo apt install nano dnsmasq
sudo systemctl start dnsmasq
sudo systemctl enable dnsmasq
dig @localhost www.google.com
```

## Gitlab Server / Tools Install

1. ホストOSのコマンドプロンプトからbitnamiでログインする
1. 以下のコマンドを実行して本リポジトリをダウンロードする

``` bash
sudo apt update
sudo apt install git
git clone http://github.com/rotace/sample_docker
```

## Docker Server / Setup

1. bitnamiからUbuntuイメージ(.iso)をダウンロード
1. Virtualbox「仮想マシン」―「新規」で以下の仮想マシンを追加する
   * 名前：docker-server
   * タイプ：Linux
   * バージョン：Ubuntu(64bit)
   * メモリ：1024MB
   * ファイルサイズ：40GB
1. Virtualbox「設定」―「ネットワーク」で「NATネットワーク」から「DockerNetwork」を選択
1. docker-serverを起動して、ディスクにisoファイルを指定する
1. 下表に示した情報を元に、インストールの案内に従ってインストールを完了する
1. ホストOSのコマンドプロンプトから、`ssh -p 12022 bitnami@localhost`でSSHログインする

| 項目 | 内容 |
| ---- | ------- |
| Your language | English |
| Keyboard Layout | Japanese |
| Network connection | Edit IPv4 => Manual |
| Network IPv4 configuration : Subnet | 10.0.11.0/24 |
| Network IPv4 configuration : Address | 10.0.11.12 |
| Network IPv4 configuration : Gateway | 10.0.11.1 |
| Network IPv4 configuration : Name servers | 10.0.11.11, 10.0.11.1 |
| Network IPv4 configuration : Search domains | |
| Your name | guest |
| Your server's name | docker-server |
| Pick a username | guest |
| Choose a password | administrator |
| Install OpenSSH server | Yes |

## Docker Server / Tools Install

1. ホストOSのコマンドプロンプトからguestでログインする
1. 以下のコマンドを実行して本リポジトリをダウンロードする

``` bash
git clone http://github.com/rotace/sample_docker
```


## Docker Server / Gitlab Runner Install

1. gitlab-runnerのリポジトリを登録し、インストールする

``` bash
cd sample_docker/gitlab/docker_server
make register-gitlab-runner-repository
sudo apt instsall gitlab-runner
```



# Reference

* [Gitlab Docs](https://docs.gitlab.com/ee/)
  * [Troubleshooting SSL](https://docs.gitlab.com/ee/administration/troubleshooting/ssl.html)
  * [Use Docker to build Docker images](https://docs.gitlab.com/ee/ci/docker/using_docker_build.html)
  * [Using SSH keys with Gitlab CI/CD](https://docs.gitlab.com/ee/ci/ssh_keys/)
  * [Gitlab Runner](https://docs.gitlab.com/runner/)
    * [Run Gitlab Runner in a container](https://docs.gitlab.com/runner/install/docker.html)
    * [Registering runners](https://docs.gitlab.com/runner/register/index.html)
* [Gitlab CI/CD 基本編 ~チュートリアルで感覚をつかむ~](https://www.insight-tec.com/tech-blog/20200929_gitlab/)
* [Gitlab CI/CD 実践編 ~Gitlab Pagesを使ったドキュメントのホスティング](https://www.insight-tec.com/tech-blog/ci-cd/20201119_gitlab/)
* [Gitlab CI/CD 発展編 ~Gitlab Runnerの使い方~](https://www.insight-tec.com/tech-blog/ci-cd/20201222_gitlab_runner/)
* [備忘録：Gitlab Runnerの登録手順](https://qiita.com/hisato_imanishi/items/28bbe6f05f8e62d1ef62)
* [Dockerコンテナ上にGitlab Runnerを構築してGitlabに登録する](https://satolabo.net/2020/04/22/regist-docker-gitlab-runner/)
* [オレオレ証明書なGitlabサーバにGitlab Runnerを登録する](https://qiita.com/tamanugi/items/170bb2bcf35a86d3111c)
* [0からGitlabCEを立ち上げてPagesを公開するまで](https://qiita.com/horit/items/a4e3c0888ab7f5ab2f2a)
* [Gitlab-CI Runner: 事故署名証明書を無視する](https://www.web-dev-qa-db-ja.com/ja/go/gitlabci%E3%83%A9%E3%83%B3%E3%83%8A%E3%83%BC%EF%BC%9A%E8%87%AA%E5%B7%B1%E7%BD%B2%E5%90%8D%E8%A8%BC%E6%98%8E%E6%9B%B8%E3%82%92%E7%84%A1%E8%A6%96%E3%81%99%E3%82%8B/831725762/)
* [HTTP化したGitlab Runnerが「SSL certificate problem...」になる](https://satolabo.net/2020/06/07/gitlab-runner-ssl-certificate-problem/)
* [Bitnami：Enable HTTPS Support With NGINX](https://docs.bitnami.com/bch/manage-servers-from-aws-console/)
