FROM node:9.3

RUN npm install -g --unsafe tldr
RUN /usr/local/bin/tldr --update

ENTRYPOINT ["/usr/local/bin/tldr"]
