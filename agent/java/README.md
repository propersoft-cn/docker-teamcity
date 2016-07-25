Propersoft TeamCity Java Agent in Docker
========================================

```
$ docker run --name tc-agent-java -p 9091:9090 -e 'TEAMCITY_SERVER=http://TEAMCITY_SERVER:8111' -e 'TEAMCITY_AGENT_PORT=9091' -e 'TEAMCITY_AGENT_NAME=Java_Agent' -d propersoft/docker-teamcity:agent-java
```
