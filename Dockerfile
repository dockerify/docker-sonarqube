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

ADD *.jar /opt/sonar/extensions/plugins/
ADD sonar-javascript-plugin-2.3.jar /opt/sonar/extensions/plugins/

VOLUME /opt/sonar/extensions
VOLUME /opt/sonar/extensions/plugins
VOLUME /opt/sonar/logs

ENV JS_PLUGIN_VERSION 2.3
RUN cd /opt/sonar/extensions/plugins && \
  curl -sLo sonar-javascript-plugin-${JS_PLUGIN_VERSION}.jar \
    http://repository.codehaus.org/org/codehaus/sonar-plugins/javascript/sonar-javascript-plugin/${JS_PLUGIN_VERSION}/sonar-javascript-plugin-${JS_PLUGIN_VERSION}.jar


ENTRYPOINT ["/app/init"]
CMD ["app:start"]
