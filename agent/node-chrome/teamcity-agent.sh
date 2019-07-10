#!/usr/bin/env bash

bash /nexus-npm.sh
bash /nexus-bower.sh

if [ ! -d "%AGENT_DIR%/bin" ]; then
    echo "%AGENT_DIR% doesn't exist pulling build-agent from server $TEAMCITY_SERVER";
    let waiting=0
    until curl -s -f -I -X GET $TEAMCITY_SERVER/update/buildAgent.zip; do
        let waiting+=3
        sleep 3
        if [ $waiting -eq 120 ]; then
            echo "Teamcity server did not respond within 120 seconds..."
            exit 42
        fi
    done
    curl -fsSLO $TEAMCITY_SERVER/update/buildAgent.zip && unzip -d $AGENT_DIR buildAgent.zip && rm buildAgent.zip
    chmod +x %AGENT_DIR%/bin/agent.sh
    echo "serverUrl=$TEAMCITY_SERVER" > %AGENT_DIR%/conf/buildAgent.properties
    echo "name=$TEAMCITY_AGENT_NAME" >> %AGENT_DIR%/conf/buildAgent.properties
    echo "ownPort=$TEAMCITY_AGENT_PORT" >> %AGENT_DIR%/conf/buildAgent.properties
fi

# if we have "--link some-docker:docker" and not DOCKER_HOST, let's set DOCKER_HOST automatically
if [ -z "$DOCKER_HOST" -a "$DOCKER_PORT_2375_TCP" ]; then
	export DOCKER_HOST="$DOCKER_PORT_2375_TCP"
fi

cd %AGENT_DIR%
%AGENT_DIR%/bin/agent.sh run
