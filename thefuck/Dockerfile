FROM python:3.6-alpine

RUN apk --no-cache --virtual .install_dependencies add gcc
RUN pip install thefuck
RUN apk del .install_dependencies

ENTRYPOINT ["/usr/local/bin/thefuck"]
