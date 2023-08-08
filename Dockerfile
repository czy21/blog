FROM registry.czy21-internal.com/library/hugo as builder

COPY . .
RUN hugo --gc --minify

FROM nginx:1.23.4-alpine
COPY --from=builder /app/public/ /usr/share/nginx/html/