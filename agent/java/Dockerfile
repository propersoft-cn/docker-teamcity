FROM java:8
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

# Set time zone
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Environment variables, safe to change in container
ENV AGENT_DIR /opt/buildAgent
ENV AGENT_HOME /home/teamcity
ENV TEAMCITY_AGENT_PORT 9090
ENV TEAMCITY_SERVER "http://teamcity:8111"

ADD nexus/nexus-gradle.sh /nexus-gradle.sh

RUN chmod +x /nexus-gradle.sh

ADD teamcity-agent.sh /teamcity-agent.sh

RUN apt-get update \
 && apt-get install -y curl git unzip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p $AGENT_DIR \
 && addgroup --system --gid 990 teamcity \
 && adduser --system --uid 990 --gid 990 --home $AGENT_HOME --shell /bin/false teamcity \
 && chown teamcity:teamcity $AGENT_DIR \
 && sed -i 's#%AGENT_DIR%#'$AGENT_DIR'#' /teamcity-agent.sh \
 && chmod +x /teamcity-agent.sh

# Install gradle
ENV GRADLE_VERSION 2.12

WORKDIR /usr/bin
RUN curl -sLO https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip && \
  unzip gradle-${GRADLE_VERSION}-all.zip && \
  ln -s gradle-${GRADLE_VERSION} gradle && \
  rm gradle-${GRADLE_VERSION}-all.zip

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

WORKDIR $AGENT_DIR
VOLUME $AGENT_HOME
VOLUME $AGENT_DIR

EXPOSE $TEAMCITY_AGENT_PORT

ENV TEAMCITY_AGENT_NAME Java_Agent

USER teamcity

ENTRYPOINT ["/teamcity-agent.sh"]
