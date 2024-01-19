FROM cm2network/steamcmd:latest

ENV PORT=8211
ENV PLAYERS=32
ENV STEAMAPPID=2394010
ENV ENABLE_MULTITHREAD=true
ENV SKIPUPDATE=false
ENV IS_PUBLIC=false
ENV PUBLIC_IP=
ENV PUBLIC_PORT=


EXPOSE 8211/udp 8211/tcp

USER root
ADD init.sh /init.sh
RUN chmod +x /init.sh
RUN ln -s /home/steam/steamcmd/steamcmd.sh /usr/local/sbin
USER steam

WORKDIR /opt/palworld


ENTRYPOINT [ "/init.sh" ]
