FROM alpine:latest
RUN apk add openjdk8-jre wget
RUN wget https://launcher.mojang.com/v1/objects/fe123682e9cb30031eae351764f653500b7396c9/server.jar
RUN echo "eula=true" > eula.txt
ENTRYPOINT java -Xmx1024M -Xms1024M -jar server.jar nogui

