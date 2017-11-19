#!/usr/bin/env bash
echo '{
  "registry" : {
    "search" : [ "http://NEXUS_USER:NEXUS_PWD@nexus.propersoft.cn:8081/repository/bower-public" ]
   },
 "resolvers" : [ "bower-nexus3-resolver" ],
  "nexus" : {
    "username" : "NEXUS_USER",
    "password" : "NEXUS_PWD"
  }
}' > /home/teamcity/.bowerrc
sed -i "s/NEXUS_USER/$NEXUS_USER/g" /home/teamcity/.bowerrc
sed -i "s/NEXUS_PWD/$NEXUS_PWD/g" /home/teamcity/.bowerrc
