Propersoft TeamCity Java Agent in Docker
========================================

```
$ docker run --name tcaj -p 9091:9090 -e 'TEAMCITY_SERVER=http://192.168.1.182:8111' -e 'TEAMCITY_AGENT_PORT=9091' -d propersoft/docker-teamcity:agent-java
```
