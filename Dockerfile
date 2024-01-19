FROM steamcmd/steamcmd:latest
ENV PORT=8211
ENV PLAYERS=32
ENV STEAMAPPID=2394010

EXPOSE 8211/udp 8211/tcp

WORKDIR /opt/palworld

COPY init.sh ./

ENTRYPOINT [ "./init.sh" ]
