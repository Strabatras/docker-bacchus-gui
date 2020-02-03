# Build:
#
# docker build -t appleboy/node-less .
#
# Run:
# docker run --rm -v `pwd`:/app -ti appleboy/node-less styles.less > styles.css

FROM node:8.0.0-alpine

RUN yarn global add less
RUN yarn global add less-plugin-clean-css
RUN yarn global add less-plugin-glob

RUN apk add --no-cache --upgrade bash

#VOLUME ["/app"]
#WORKDIR /app

#ENTRYPOINT ["/usr/local/bin/lessc"]