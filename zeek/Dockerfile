FROM ubuntu:20.04 as builder

LABEL maintainer "https://github.com/retr0h"

ENV DEBIAN_FRONTEND noninteractive
ENV PATH $PATH:/opt/zeek/bin

RUN \
  apt-get update \
  && apt-get install -y gnupg curl cmake clang linux-generic

RUN \
  echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_20.04/ /' > /etc/apt/sources.list.d/security:zeek.list \
  && curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_20.04/Release.key | gpg --dearmor > /etc/apt/trusted.gpg.d/security_zeek.gpg \
  && apt-get update \
  && apt-get install -y zeek-lts zkg btest

RUN \
  zkg autoconfig

RUN \
  CC=clang zkg install zeek-af_packet-plugin --force \
  && zeek -NN Zeek::AF_Packet

RUN \
  CC=clang zkg install zeek/corelight/zeek-community-id --force \
  && zeek -NN Corelight::CommunityID

### runtime ###

FROM ubuntu:20.04

LABEL maintainer "https://github.com/retr0h"
LABEL zeek.version "3.2.3"

RUN \
  apt-get update \
  && apt-get install -y libpcap-dev libssl-dev python3 iproute2 \
  && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
  && apt-get clean

COPY --from=builder /opt/zeek/ /opt/zeek/
COPY --from=builder /root/.zkg/ /root/.zkg/
COPY zeek/local.zeek /opt/zeek/share/zeek/site/local.zeek

ENV PATH $PATH:/opt/zeek/bin

ENTRYPOINT ["zeek"]
CMD ["-h"]
