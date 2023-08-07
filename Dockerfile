FROM ubuntu:jammy as builder
ENV HUGO_VERSION=0.116.1
WORKDIR /app

COPY . .
RUN apt update -y && apt install wget -y
RUN wget -nv -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb && dpkg -i /tmp/hugo.deb
RUN hugo --gc --minify

FROM nginx:1.23.4-alpine
COPY --from=builder /app/public/ /usr/share/nginx/html/