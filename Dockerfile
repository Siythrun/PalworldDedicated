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

WORKDIR /opt/palworld

COPY init.sh /
COPY run.sh /home/steam/
RUN chmod +x /init.sh /home/steam/run.sh

ENTRYPOINT [ "/init.sh" ]
