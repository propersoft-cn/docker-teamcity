Propersoft TeamCity Ionic Agent with Node in Docker
===================================================

## How to use

```
$ docker run --name tc-agent-ionic -e 'TEAMCITY_SERVER=http://teamcityserver' -e 'TEAMCITY_AGENT_NAME=Ionic_Agent' -e 'NEXUS_USER=user' -e 'NEXUS_PWD=pwd' -e 'NEXUS_TOKEN=xxxx' -d propersoft/docker-teamcity:agent-ionic
```

## Reference

[appunite/docker](https://github.com/appunite/docker)
