FROM eclipse-temurin:17-jre-alpine
RUN apk add curl wget bash grep jq
RUN adduser -D -s /bin/bash minecraft
RUN mkdir /data && chown -R minecraft:minecraft /data
USER minecraft
WORKDIR /home/minecraft
COPY scripts/install.sh .
RUN INSTALL_DIRECTORY=/data sh install.sh
RUN echo "eula=true" > eula.txt
ENTRYPOINT ["/opt/java/openjdk/bin/java", "-Xmx1024M", "-Xms1024M", "-jar", "/data/server.jar", "nogui"]

