FROM alpine:3.4

# Alpine packages
RUN apk --no-cache \
    add \
        curl \
        bash \
        ca-certificates

ENV CONSUL_VERSION=1.0.0
RUN export CONSUL_CHECKSUM=585782e1fb25a2096e1776e2da206866b1d9e1f10b71317e682e03125f22f479 \
    && export archive=consul_${CONSUL_VERSION}_linux_amd64.zip \
    && curl -Lso /tmp/${archive} https://releases.hashicorp.com/consul/${CONSUL_VERSION}/${archive} \
    && echo "${CONSUL_CHECKSUM}  /tmp/${archive}" | sha256sum -c \
    && cd /bin \
    && unzip /tmp/${archive} \
    && chmod +x /bin/consul \
    && rm /tmp/${archive}

ENV CONTAINERPILOT_VER=3.6.1
ENV CONTAINERPILOT=/etc/containerpilot.json5
RUN export CONTAINERPILOT_CHECKSUM=57857530356708e9e8672d133b3126511fb785ab \
    && curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VER}/containerpilot-${CONTAINERPILOT_VER}.tar.gz" \
    && echo "${CONTAINERPILOT_CHECKSUM}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /usr/local/bin \
    && rm /tmp/containerpilot.tar.gz \
    && mkdir -p /tmp/outputs

COPY etc/containerpilot.json5 etc/
COPY bin/cp-log usr/bin/
COPY outputs/*.log tmp/outputs/

EXPOSE 3030 8500

ENV SHELL /bin/bash
