FROM steamcmd/steamcmd:latest
ENV PORT=8211
ENV PLAYERS=32

EXPOSE 8211/udp 8211/tcp

WORKDIR /opt/palworld

RUN steamcmd  +force_install_dir "/opt/palworld" +login anonymous +app_update 2394010 validate +quit

COPY init.sh ./

ENTRYPOINT [ "./init.sh" ]
