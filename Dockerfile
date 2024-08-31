FROM eclipse-temurin:21.0.4_7-jre-jammy

COPY bin /usr/adeptj-runtime-launcher/bin
COPY haproxy /usr/adeptj-runtime-launcher/haproxy
COPY target/adeptj-runtime-launcher.jar /usr/adeptj-runtime-launcher
COPY target/lib /usr/adeptj-runtime-launcher/lib

WORKDIR /usr/adeptj-runtime-launcher

EXPOSE 8080

RUN chmod +x /usr/adeptj-runtime-launcher/bin/start.sh

ENTRYPOINT ["bash","/usr/adeptj-runtime-launcher/bin/start.sh"]