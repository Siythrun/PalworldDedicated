FROM steamcmd/steamcmd:latest

ENV PORT=8211
ENV PLAYERS=32
ENV STEAMAPPID=2394010
ENV ENABLE_MULTITHREAD=true
ENV SKIPUPDATE=false
ENV IS_PUBLIC=false
ENV PUBLIC_IP=
ENV PUBLIC_PORT=
ENV PGID="1000"
ENV PUID="1000" 


EXPOSE 8211/udp 8211/tcp

RUN useradd -ms /bin/bash steam 

RUN mkdir -p /opt/palworld \
 && chown steam:steam /opt/palworld

WORKDIR /opt/palworld

COPY init.sh /
COPY --chown=steam:steam run.sh /home/steam/
RUN chmod +x /init.sh /home/steam/run.sh

ENTRYPOINT [ "/init.sh" ]
