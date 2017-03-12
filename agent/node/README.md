Propersoft TeamCity Node Agent in Docker
========================================

```
$ docker run --name tc-agent-node -p 9092:9090 -e 'TEAMCITY_SERVER=http://TEAMCITY_SERVER:8111' -e 'TEAMCITY_AGENT_PORT=9092' -e 'NEXUS_USER=xxx' -e 'NEXUS_PWD=xxx' -e 'NEXUS_TOKEN=xxx' -e 'TEAMCITY_AGENT_NAME=MAC_NODE_AGENT' -d propersoft/docker-teamcity:agent-node
```
