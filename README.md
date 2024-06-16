# RailsアプリケーションのAWSインフラ環境をCircleci+Ansibleで自動構築した<!-- omit in toc -->

## 目次<!-- omit in toc -->

- [実施概要](#実施概要)
- [開発環境](#開発環境)
- [使用ツール](#使用ツール)
- [事前設定](#事前設定)
- [各ツールの設定](#各ツールの設定)
  - [CloudFormationの設定](#cloudformationの設定)
  - [Ansibleの設定](#ansibleの設定)
  - [ServerSpecの設定](#serverspecの設定)
- [Circleciの実行結果を確認](#circleciの実行結果を確認)
- [反省点](#反省点)

---

## 実施概要

- AWSのリソースをCircleci+Ansibleで自動構築した
- 今回はインフラの自動構築を目標とするため、既存のCRUD処理が出来る簡単なRailsアプリケーションを利用した
<img width="450" src=images/構成図.png><br>

**EC2**  

- 今回は学習コストを抑えるため1台構成とした
- EIPを使用して利便性を高めた

**RDS**  

- 今回は学習コストを抑えるためシングルAZ構成とした
- トラフィックはEC2にアサインしたセキュリティグループのみを許可する設定とした

**ELB**  

- EC2の前に設置し、受信したHTTP/HTTPSトラフィックをEC2へルーティングさせる
- アプリケーションの拡張性と可用性を考慮しALBを選択した

**S3**  

- アプリケーションの画像保存先として使用することで、データの可用性と耐久性を確保した

---

## 開発環境

- Ubuntu(Windows 11 Home/WSL2)
- VScode

## 使用ツール

**CircleCI**  

- CloudFormationの実行  
- Ansibleの実行
- ServerSpecの実行

**CloudFormation**  

- VPC、EC2、RDS、ELB、S3を作成（詳細は上記構成図に記載）

**Ansible**  

- Railsアプリケーション用の環境構築を行う

**ServerSpec**  

- Railsアプリケーションのレスポンスを確認する

---

## 事前設定

必要な環境変数はCircleCIの `Environment Variables` に登録することで、コード変更を不要とした。

<img width="450" src=images/01.png>

---

## 各ツールの設定

1. CloudFormationの設定
2. Ansibleの設定
3. ServerSpecの設定
4. Circleciの実行結果を確認
5. Railsアプリケーションの動作確認

---

### CloudFormationの設定

---

詳細は[CloudFormationのテンプレート](cloudformation)を参照。<br>
AWS CLIを用いてCloudFormationを実行する設定を[config.yml](.circleci/config.yml)に追加。  

---

### Ansibleの設定

---

[config.yml](.circleci/config.yml)にAnsibleのplaybook.ymlを実行する設定を追加。（[Ansibleの設定ファイル](ansible)）

---

### ServerSpecの設定

---

ServerSpecのテストスクリプトを実行する設定を[config.yml](.circleci/config.yml)に追加。

---

## Circleciの実行結果を確認

---

1. 結果一覧<br>![全結果](images/02.png)
2. cfn-lintの結果<br>![cfn-lint](images/03.png)
3. execute-cfnの結果<br>![execute-cfn](images/04.png)
4. execute-ansibleの結果<br>![execute-ansible](images/05.png)
5. execute-serverspecの結果<br>![execute-serverspec](images/06.png)

---

## 反省点

- 一つ一つエラーログを見ながら対応したが、Railsアプリケーションへの理解が足りていないことを実感した。今後はRailsの学習をし理解を深めたい。
- アプリのリクエストがhttp通信でセキュリティ上問題があるためhttps通信へリダイレクトするよう変更したい
