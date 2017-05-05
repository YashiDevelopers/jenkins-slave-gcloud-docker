FROM jenkinsci/jnlp-slave:3.7-1-alpine

MAINTAINER Chris Ingrassia <c.ingrassia@yashi.com>

USER root

RUN apk add --no-cache docker ca-certificates wget tar python libstdc++ libc6-compat nodejs-current \
  && update-ca-certificates \
  && wget -q -O /tmp/gcloud.tgz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-154.0.0-linux-x86_64.tar.gz \
  && mkdir -p /opt/gcloud \
  && tar xzf /tmp/gcloud.tgz -C /opt/gcloud --strip-components=1 \
  && rm -f /tmp/gcloud.tgz \
  && rm -f /var/cache/apk/* \
  && npm install -g react relay graphql express es6 es7 jsx webpack babel postcss scaffolding fullstack

ENV PATH=$PATH:/opt/gcloud/bin

USER jenkins
