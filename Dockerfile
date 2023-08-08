FROM registry.czy21-internal.com/library/hugo as builder
ARG ALGOLIA_ADMIN_KEY
ARG HUGO_BASEURL

COPY . .
RUN hugo --gc --minify --environment prod
RUN npm install && npm run algolia

FROM nginx:1.23.4-alpine
COPY --from=builder /app/public/ /usr/share/nginx/html/