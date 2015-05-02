FROM ubuntu:vivid
MAINTAINER Sascha Spreitzer <sascha@spreitzer.ch>

ENV VERSION 2.14-1

RUN apt-get update && apt-get install -y openssl openssh-client supervisor sudo shellinabox=${VERSION} && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh /
ADD shellinabox.conf /etc/supervisor/conf.d/

ENV SIAB_USERCSS Black on White:+/etc/shellinabox/options-enabled/00+Black on White.css,White On Black:-/etc/shellinabox/options-enabled/00_White On Black.css;Color Terminal:+/etc/shellinabox/options-enabled/01+Color Terminal.css,Monochrome:-/etc/shellinabox/options-enabled/01_Monochrome.css
ENV SIAB_PORT 4200
ENV SIAB_ADDUSER true
ENV SIAB_USER guest
ENV SIAB_PASSWORD putsafepasswordhere
ENV SIAB_SUDO false
ENV SIAB_SSL true
ENV SIAB_SERVICE "/:LOGIN"

EXPOSE 4200

VOLUME /etc/shellinabox
VOLUME /var/log/supervisor
VOLUME /home

ENTRYPOINT ["/entrypoint.sh"]
CMD ["shellinabox"]
