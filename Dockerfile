# Build stage
FROM trion/ng-cli-karma AS builder
#FROM node:current-alpine AS builder
LABEL maintainer="nicklas@wiegandt.eu,thesasch_github@wiegandt.net"
USER root
WORKDIR /tmp
# copy app files
COPY . .
# install node packages
RUN npm update
RUN npm install -g npm@7.1.1 && \
#build package
    npm run all

FROM nginx:stable-alpine
LABEL maintainer="nicklas@wiegandt.eu,thesasch_github@wiegandt.net"

COPY --from=builder --chown=101:101 /tmp/dist /usr/share/nginx/html
