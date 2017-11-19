#!/usr/bin/env bash
mkdir -p /home/teamcity/.gradle
echo 'nexusUrl=http://nexus.propersoft.cn:8081
nexusUsername=NEXUS_USER
nexusPassword=NEXUS_PWD
org.gradle.jvmargs=-Xmx2048M' > /home/teamcity/.gradle/gradle.properties
sed -i "s/NEXUS_USER/$NEXUS_USER/g" /home/teamcity/.gradle/gradle.properties
sed -i "s/NEXUS_PWD/$NEXUS_PWD/g" /home/teamcity/.gradle/gradle.properties
