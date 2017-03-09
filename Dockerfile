FROM jenkinsci/jnlp-slave:2.62-alpine

MAINTAINER Chris Ingrassia <chris@noneofyo.biz>

USER root

ARG SPARK_VERSION=2.1.0

ARG SPARK_URL=http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
  && echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
  && apk add --no-cache docker ca-certificates wget tar python2 py2-pip py2-numpy python2-dev gcc make libstdc++ maven \
  && update-ca-certificates \
  && wget -q -O /tmp/gcloud.tgz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-146.0.0-linux-x86_64.tar.gz \
  && mkdir -p /opt/gcloud \
  && tar xzf /tmp/gcloud.tgz -C /opt/gcloud --strip-components=1 \
  && rm -f /tmp/gcloud.tgz \
  && rm -f /var/cache/apk/* \
  && wget -q -O /tmp/spark.tgz ${SPARK_URL} \
  && mkdir -p /opt/spark \
  && tar xzf /tmp/spark.tgz -C /opt/spark --strip-components=1 \
  && rm -f /tmp/spark.tgz

ENV PATH=$PATH:/opt/gcloud/bin:/opt/spark/bin
