FROM ruby:alpine

RUN apk add git
RUN apk --no-cache --virtual .install_dependencies add build-base
RUN gem install travis
RUN apk del .install_dependencies

ENTRYPOINT ["travis"]
