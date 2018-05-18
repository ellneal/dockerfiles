FROM node:alpine

RUN npm install -g --unsafe tldr
RUN /usr/local/bin/tldr --update

ENTRYPOINT ["/usr/local/bin/tldr"]
