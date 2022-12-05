FROM alpine:latest as base
RUN apk add curl jq
COPY scripts/install.sh .
RUN sh install.sh

FROM eclipse-temurin:17-jre-alpine
RUN adduser -D -h /minecraft minecraft
COPY --from=base /minecraft/server.jar /minecraft/server.jar
RUN chown -R minecraft:minecraft /minecraft
USER minecraft
WORKDIR /home/minecraft
RUN echo "eula=true" > eula.txt
ENTRYPOINT ["/opt/java/openjdk/bin/java", "-Xmx1024M", "-Xms1024M", "-jar", "/minecraft/server.jar", "nogui"]

