FROM alpine:latest

RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

RUN mkdir /data
ADD index.html /data

VOLUME /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]