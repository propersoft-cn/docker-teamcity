#!/usr/bin/env bash
echo 'registry=https://server.propersoft.cn:8081/repository/npm-public/ 
//server.propersoft.cn:8081/repository/npm-public/:_authToken=NEXUS_TOKEN' > /root/.npmrc
sed -i "s/NEXUS_TOKEN/$NEXUS_TOKEN/g" /root/.npmrc
