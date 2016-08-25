#!/usr/bin/env bash
sed -i "s/NEXUS_USER/$NEXUS_USER/g" /root/.gradle/gradle.properties
sed -i "s/NEXUS_PWD/$NEXUS_PWD/g" /root/.gradle/gradle.properties
