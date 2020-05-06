FROM alpine:latest
RUN apk update --no-cache && apk upgrade --no-cache
RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
RUN apk add --update --no-cache curl openssh openntp vim wget && rm -rf /var/cache/apk/*
COPY entrypoint.sh /
CMD ["curl"]
ENTRYPOINT ["/entrypoint.sh"]
