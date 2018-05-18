FROM ruby:2.3-alpine

RUN mkdir -p /opt/src
COPY report.rb /opt/src/report.rb

ENTRYPOINT ["/usr/local/bin/ruby", "/opt/src/report.rb"]
