FROM alpine:latest
RUN apk add openjdk8-jre curl wget bash grep
RUN adduser -D -s /bin/bash minecraft
USER minecraft
WORKDIR /home/minecraft
RUN wget $(curl -s https://www.minecraft.net/en-us/download/server/ | grep -oP 'https://launcher.mojang.com/v1/objects/[a-zA-Z0-9]+/server.jar')
RUN echo "eula=true" > eula.txt
ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]

