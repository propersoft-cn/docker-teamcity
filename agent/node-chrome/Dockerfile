FROM node:latest
MAINTAINER Alpha Hinex <AlphaHinex@gmail.com>

# Set time zone
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Environment variables, safe to change in container
ENV AGENT_DIR /opt/buildAgent
ENV AGENT_HOME /home/teamcity
ENV TEAMCITY_AGENT_PORT 9090
ENV TEAMCITY_SERVER "http://teamcity:8111"

ADD nexus/nexus-npm.sh /nexus-npm.sh
ADD nexus/nexus-bower.sh /nexus-bower.sh

RUN chmod +x /nexus-npm.sh
RUN chmod +x /nexus-bower.sh

ADD teamcity-agent.sh /teamcity-agent.sh

RUN apt-get update \
 && apt-get install -y curl git unzip openjdk-8-jdk ruby ruby-dev fonts-liberation libappindicator3-1 libatk-bridge2.0-0 libatspi2.0-0 libgtk-3-0 libxss1 lsb-release xdg-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p $AGENT_DIR \
 && addgroup --system --gid 990 teamcity \
 && adduser --system --uid 990 --gid 990 --home $AGENT_HOME --shell /bin/false teamcity \
 && chown teamcity:teamcity $AGENT_DIR \
 && sed -i 's#%AGENT_DIR%#'$AGENT_DIR'#' /teamcity-agent.sh \
 && chmod +x /teamcity-agent.sh

ADD google-chrome-stable_current_amd64.deb /google-chrome-stable_current_amd64.deb 
RUN dpkg -i /google-chrome-stable_current_amd64.deb 
RUN apt-get update
ADD chromedriver /chromedriver
RUN chmod a+x /chromedriver \
  && cp /chromedriver /usr/bin/ \
  && cp /chromedriver /usr/local/bin/ \
  && rm -rf /opt/google/chrome/google-chrome

ADD google-chrome /opt/google/chrome/google-chrome
RUN chmod +x /opt/google/chrome/google-chrome

WORKDIR $AGENT_DIR
VOLUME $AGENT_HOME
VOLUME $AGENT_DIR

EXPOSE $TEAMCITY_AGENT_PORT

RUN npm install -g bower grunt-cli bower-nexus3-resolver ionic
RUN gem install sass compass

ENV TEAMCITY_AGENT_NAME "NodeJS_Agent"

USER teamcity

ENTRYPOINT ["/teamcity-agent.sh"]
