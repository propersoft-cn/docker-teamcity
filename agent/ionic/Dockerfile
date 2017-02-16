FROM ubuntu:16.04

MAINTAINER Alpha Hinex "AlphaHinex@gmail.com"

# Install java8
RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections) && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  apt-get clean && \
  rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes unzip expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl libqt5widgets5 && apt-get clean && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy install tools
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && \
  tar xzf android-sdk.tgz && \
  rm -f android-sdk.tgz && \
  chown -R root.root android-sdk-linux && \
  /opt/tools/android-accept-licenses.sh "android-sdk-linux/tools/android update sdk --all --no-ui --filter platform-tools,tools" && \
  /opt/tools/android-accept-licenses.sh "android-sdk-linux/tools/android update sdk --all --no-ui --filter platform-tools,tools,build-tools-22.0.1,build-tools-23.0.3,build-tools-24.0.3,build-tools-25.0.0,build-tools-25.0.1,android-21,android-22,android-23,android-24,android-25,addon-google_apis_x86-google-21,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services,sys-img-armeabi-v7a-android-24"

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN which adb
RUN which android

# Cleaning
RUN apt-get clean

# Set time zone
RUN echo "Asia/Shanghai" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# Install nodejs and npm
RUN apt-get update && apt-get install -y nodejs && apt-get install -y nodejs-legacy && apt-get -y install npm

# Environment variables, safe to change in container
ENV AGENT_DIR /opt/buildAgent
ENV AGENT_HOME /home/teamcity
ENV TEAMCITY_AGENT_PORT 9090
ENV TEAMCITY_SERVER "http://teamcity:8111"

ADD nexus/nexus-npm.sh /nexus-npm.sh
ADD nexus/nexus-bower.sh /nexus-bower.sh
ADD nexus/nexus-gradle.sh /nexus-gradle.sh

RUN chmod +x /nexus-npm.sh
RUN chmod +x /nexus-bower.sh
RUN chmod +x /nexus-gradle.sh

ADD teamcity-agent.sh /teamcity-agent.sh

RUN apt-get update \
 && apt-get install -y curl git unzip ruby ruby-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p $AGENT_DIR \
 && addgroup --system --gid 990 teamcity \
 && adduser --system --uid 990 --gid 990 --home $AGENT_HOME --shell /bin/false teamcity \
 && chown teamcity:teamcity $AGENT_DIR \
 && sed -i 's#%AGENT_DIR%#'$AGENT_DIR'#' /teamcity-agent.sh \
 && chmod +x /teamcity-agent.sh

# Install gradle
ENV GRADLE_VERSION 2.13

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

RUN npm install -g bower
RUN npm install -g bower-nexus3-resolver
RUN npm install -g grunt-cli
RUN npm install -g cordova
RUN npm install -g ionic
RUN npm install -g cordova-hot-code-push-cli
RUN gem install sass compass

ENV TEAMCITY_AGENT_NAME "Ionic_Agent"

USER teamcity

ENTRYPOINT ["/teamcity-agent.sh"]
