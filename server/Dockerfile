FROM java:7
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

# Set time zone
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Get and install teamcity
ENV TEAMCITY_VERSION 9.1.7
ENV TEAMCITY_DATA_PATH /var/lib/teamcity
ENV TEAMCITY_CONTEXT teamcity

RUN wget -qO- https://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.tar.gz | tar xz -C /opt

# Enable the correct Valve when running behind a proxy
RUN sed -i -e "s/\.*<\/Host>.*$/<Valve className=\"org.apache.catalina.valves.RemoteIpValve\" protocolHeader=\"x-forwarded-proto\" \/><\/Host>/" /opt/TeamCity/conf/server.xml

COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 8111

VOLUME $TEAMCITY_DATA_PATH

ENTRYPOINT ["/docker-entrypoint.sh"]