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
# 安装常用软件
RUN apk add --update --no-cache curl openssh vim wget bash python3 go php7 openjdk11 nodejs npm && rm -rf /var/cache/apk/*
# 配置vim(右键不能粘贴，反而进入了visual模式)
#RUN sed -i "s/set mouse=a/set mouse-=a/g" /usr/share/vim/vim82/defaults.vim
RUN sed -i "s/set mouse=a/set mouse-=a/g" `find / -name defaults.vim`
# 配置ssh
RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
    echo "root:admin" | chpasswd
# rc-service sshd restart
COPY entrypoint.sh /
RUN cd / && chmod +x entrypoint.sh
CMD ["ssh","wget","curl"]
# 开放22端口
EXPOSE 22
# 执行ssh启动命令
CMD ["/usr/sbin/sshd", "-D"]
#ENTRYPOINT ["/entrypoint.sh"]
