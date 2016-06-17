Propersoft TeamCity Node Agent in Docker
========================================

```
$ docker run --name tc-agent-node -p 9092:9090 -e 'TEAMCITY_SERVER=http://TEAMCITY_SERVER:8111' -e 'TEAMCITY_AGENT_PORT=9092' -d propersoft/docker-teamcity:agent-node
```
