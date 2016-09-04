#!/usr/bin/env bash
echo 'nexusUrl=https://server.propersoft.cn:8081
nexusUsername=NEXUS_USER
nexusPassword=NEXUS_PWD' > /home/teamcity/.gradle/gradle.properties
sed -i "s/NEXUS_USER/$NEXUS_USER/g" /home/teamcity/.gradle/gradle.properties
sed -i "s/NEXUS_PWD/$NEXUS_PWD/g" /home/teamcity/.gradle/gradle.properties
