FROM debian:bullseye as builder
WORKDIR /app

COPY . .
RUN ls -al
RUN apt install hugo
RUN hugo --gc --minify
RUN ls -al

FROM nginx:1.23.4-alpine
COPY --from=builder /app/public/ /usr/share/nginx/html/