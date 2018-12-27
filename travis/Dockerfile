FROM ruby:alpine

RUN apk --no-cache --virtual .install_dependencies add git build-base
RUN gem install travis
RUN apk del .install_dependencies

ENTRYPOINT ["travis"]
