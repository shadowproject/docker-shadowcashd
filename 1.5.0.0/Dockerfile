FROM debian:latest

MAINTAINER Juha Kovanen <juha.kovanen@gmail.com>

RUN useradd -r shadowcash

ENV GOSU_VERSION=1.7

RUN apt-get update -y \
  && apt-get install -y curl unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4

RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
	&& curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

ENV SHADOWCASH_VERSION=1.5.0.0
ENV SHADOWCASH_DATA=/home/shadowcash/.shadowcoin \
  PATH=/opt/shadowcash-${SHADOWCASH_VERSION}/bin:$PATH

VOLUME ["/home/shadowcash/.shadowcoin"]

# copy latest shadowcash
WORKDIR /tmp
RUN curl -SLO https://github.com/shadowproject/shadow/releases/download/v${SHADOWCASH_VERSION}/umbra_${SHADOWCASH_VERSION}_linux.zip
RUN mkdir -p /opt/shadowcash-${SHADOWCASH_VERSION}/bin
RUN unzip /tmp/umbra_${SHADOWCASH_VERSION}_linux.zip -d /opt/shadowcash-${SHADOWCASH_VERSION}/bin
RUN rm /tmp/umbra_${SHADOWCASH_VERSION}_linux.zip

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 51736 51737

CMD ["shadowcoind"]
