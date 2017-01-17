FROM jenkinsci/jnlp-slave:2.62-alpine

MAINTAINER Chris Ingrassia <chris@noneofyo.biz>

USER root

RUN apk add --no-cache docker ca-certificates wget tar python libstdc++ \
  && update-ca-certificates \
  && wget -O /tmp/gcloud.tgz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-138.0.0-linux-x86_64.tar.gz \
  && mkdir -p /opt/gcloud \
  && tar xzf /tmp/gcloud.tgz -C /opt/gcloud --strip-components=1 \
  && rm -f /tmp/gcloud.tgz \
  && rm -f /var/cache/apk/*

ENV PATH=$PATH:/opt/gcloud/bin

USER jenkins
