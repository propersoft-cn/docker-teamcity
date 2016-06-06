Propersoft TeamCity Server in Docker
====================================

```
$ docker pull propersoft/docker-teamcity
$ docker run --name tc -v /home/ds/teamcity:/var/lib/teamcity -p 9103:8111 -d propersoft/docker-teamcity:latest
```
