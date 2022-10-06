#使用するlogstashのバージョンを指定
FROM docker.elastic.co/logstash/logstash:7.1.0

USER root

#必要なモジュールのインストールやファイル配置
#yum installコマンド実行時に使用するリポジトリを定義
RUN yum install -y epel-release \
#Deploymentでjqコマンドを使用するためインストール
&&  yum install -y jq-1.6-2.el7 \
#outputにDBを指定する場合に必要なプラグイン
&&  logstash-plugin install logstash-output-jdbc \
#必要ファイルをコピーするコンテナ内のディレクトリを初期化のため削除
&& rm -rf /usr/share/logstash/pipeline \
          /usr/share/logstash/config

#必要なファイルをコンテナ内に配置
#例ではjdbcドライバ、パイプライン、コンフィグを使用するためコピー
COPY ./postgresql-42.1.4.jre7.jar /usr/share/logstash/vendor/jar/jdbc/postgresql-42.1.4.jre7.jar
COPY ./pipeline /usr/share/logstash/pipeline
COPY ./config /usr/share/logstash/config
