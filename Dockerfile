FROM java:7
MAINTAINER spiddy <d.kapanidis@gmail.com>

RUN echo "deb http://downloads.sourceforge.net/project/sonar-pkg/deb binary/" >> /etc/apt/sources.list
RUN apt-get update && apt-get clean ### Sonar version 5.0 - timestamp

RUN apt-get install -y --force-yes sonar=5.0

COPY assets/init /app/init
RUN chmod 755 /app/init

CMD ["mkdir", "/opt/sonar/extensions"]
CMD ["mkdir", "/opt/sonar/extensions/plugins"]
CMD ["mkdir", "/opt/sonar/logs"]

VOLUME /opt/sonar/extensions
VOLUME /opt/sonar/extensions/plugins
VOLUME /opt/sonar/logs

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
