# sample_docker
Dockerのサンプルコマンド集


| フォルダ名／ファイル名 | 内容 |
| --- | --- |
| 3step_tutorial | 3ステップのチュートリアル |
| gitlab | Gitlabとの連携環境構築サンプル |
| offline | オフライン環境構築サンプル |
| pytest | Python単体テストサンプル |
| .gitlab-ci.yml | 「Gitlabとの連携環境構築サンプル」で使用するGitlab CI/CDの設定ファイル |
| Doxyfile | Doxygenの設定ファイル |
| Makefile | Dockerの基本コマンドを集めたコマンド集 |

## Commands

makeコマンドによるショートカットを以下に示す。

| makeコマンド | 操作内容 |
| --- | --- |
| make web.setup | WEBサーバを起動する |
| make web.clean | WEBサーバをシャットダウンする |
| make doc.exec | ドキュメントを生成する |
| make doc.deploy | ドキュメントを生成し、WEBサーバへデプロイする |
| make doc.clean | 生成したドキュメントを削除する |

## Reference

* [Docker ドキュメント日本語化プロジェクト](https://docs.docker.jp/)
* [Docker入門（第六回）〜Docker Compose〜](https://knowledge.sakura.ad.jp/16862/)
* [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)
* [GitLab CIとは？GitLab上でユニットテストを自動化する方法](https://techblog.nhn-techorus.com/archives/12531)
* [dockerを利用したdoxygenの導入](https://qiita.com/hyt-sasaki/items/8f8312e277d1a4815ab6)