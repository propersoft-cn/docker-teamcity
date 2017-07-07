Propersoft TeamCity Server in Docker
====================================

```
$ docker-compose up -d
```

### 关于 `TEAMCITY_CONTEXT` 环境变量的说明

`docker-compose.yml` 中可以配置 `TEAMCITY_CONTEXT` 环境变量。

`entrypoint.sh` 会将 tomcat 里的 webapp 更名为这个变量的值。

为避免 TeamCity 启动时的异常情况，该环境变量的值必须设置为与 TeamCity Server 的服务器地址 URL 上下文根一致，且不能为空。

例如 TeamCity Server 的地址为 http://teamcity:8111/tc，则 `TEAMCITY_CONTEXT` 需设置为 `tc`。TeamCity Server 的地址 **不能是多级**，如不可以为 http://teamcity:8111/xxx/tc 。
