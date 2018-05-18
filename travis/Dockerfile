FROM ruby:2.3-alpine

RUN apk --no-cache --virtual .install_dependencies add git gcc
RUN gem install travis -v 1.8.8 --no-rdoc --no-ri
RUN apk del .install_dependencies

ENTRYPOINT ["travis"]
