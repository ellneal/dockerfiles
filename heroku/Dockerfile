FROM node:alpine

# RUN apk update && apk add git
RUN apk --no-cache --virtual .install_dependencies add git
RUN npm install -g heroku
RUN apk del .install_dependencies

ENTRYPOINT ["/usr/local/bin/heroku"]
