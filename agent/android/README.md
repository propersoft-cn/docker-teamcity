Propersoft TeamCity Android Agent with Node in Docker
=====================================================

```
$ docker run --name tc-agent-android -e 'TEAMCITY_SERVER=https://server.propersoft.cn/teamcity' -e 'NEXUS_USER=propersoft-ci' -e 'NEXUS_PWD=ppC1' -e 'NEXUS_TOKEN=416d54b5-6f9e-35d7-8a14-30a941d0f045' -d propersoft/docker-teamcity:agent-android
```
