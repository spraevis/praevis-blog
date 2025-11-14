FROM ghcr.io/gohugoio/hugo:v0.152.2 AS build
WORKDIR /src
COPY . .
RUN hugo --minify

FROM nginx:alpine
COPY --from=build /src/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
