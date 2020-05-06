FROM alpine:latest
MAINTAINER Aplha
# 替换阿里云的源
RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories
RUN echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories
RUN apk update --no-cache && apk upgrade --no-cache
# 设置时区
RUN apk --no-cache add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
RUN apk add --update --no-cache curl openssh vim wget bash python3 && rm -rf /var/cache/apk/*
RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && rc-service sshd restart
COPY entrypoint.sh /
CMD ["curl"]
ENTRYPOINT ["/entrypoint.sh"]
