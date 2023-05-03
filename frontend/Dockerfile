FROM node:16.9.1 AS builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build
FROM nginx:1.23.3-alpine-slim AS build-release
COPY --from=builder /usr/src/app/dist /usr/share/nginx/html
RUN mkdir -p /var/cache/nginx && chown nginx:nginx /var/cache/nginx