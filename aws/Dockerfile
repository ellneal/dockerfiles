FROM python:3-alpine

RUN apk --no-cache --virtual add groff
RUN pip install awscli

RUN mkdir -p /root/.aws

WORKDIR /opt/content

ENTRYPOINT ["/usr/local/bin/aws"]
