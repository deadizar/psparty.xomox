# Thx: https://betterstack.com/community/guides/scaling-nodejs/dockerize-nodejs/#step-2-creating-a-docker-image-for-your-node-js-app
# Use Node 20.16 alpine as base image
FROM alpine:3.21.2@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099 AS base
LABEL authors="deadizar"

# Change the working directory to ./build
WORKDIR ./build

VOLUME /data
COPY ./data /data

# Copy the package.json and package-lock.json files to the /build directory
COPY package.json ./
COPY package-lock.json ./

# Install production dependencies and clean the cache
RUN npm ci --omit=dev && npm cache clean --force

MKDIR server
COPY ./server /server

EXPOSE 4443
ENTRYPOINT ["node"]
CMD ["./server/resources/app/main.js", "--headless", "--dataPath=/data" ]
