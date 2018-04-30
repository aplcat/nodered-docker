FROM nodered/node-red-docker:slim

ENV SSH_PORT=2022
ENV EXT_PORT=3000
ENV RED_PORT=1880

USER root

RUN apk --no-cache upgrade \
 && apk --no-cache add \
    cmake libuv-dev build-base \
    sudo bash wget curl openssh git \
    python

# Install dumb-init (avoid PID 1 issues). https://github.com/Yelp/dumb-init
RUN curl -Lo /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 \
 && chmod +x /usr/local/bin/dumb-init

# Prepare SSH service
RUN echo "Port $SSH_PORT" >> /etc/ssh/sshd_config \
 && mkdir -p /var/empty && chmod 700 /var/empty \
 && export SSH_PORT=$SSH_PORT

USER node-red
EXPOSE $RED_PORT $EXT_PORT
VOLUME /data

ADD entrypoint.sh /
ENTRYPOINT  ["dumb-init","/entrypoint.sh"]
