FROM ubuntu:jammy as builder
WORKDIR /app

COPY . .
RUN ls -al
RUN apt-get update && apt install hugo
RUN hugo --gc --minify
RUN ls -al

FROM nginx:1.23.4-alpine
COPY --from=builder /app/public/ /usr/share/nginx/html/