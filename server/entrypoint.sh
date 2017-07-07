#!/bin/bash
set -e

mkdir -p $TEAMCITY_DATA_PATH/lib/jdbc $TEAMCITY_DATA_PATH/config $TEAMCITY_DATA_PATH/plugins

if [ ! -f "$TEAMCITY_DATA_PATH/lib/jdbc/mysql-connector-java-5.1.40.jar" ];
then
    echo "Downloading mysql JDBC driver..."
    curl -o $TEAMCITY_DATA_PATH/lib/jdbc/mysql-connector-java-5.1.40.jar https://repo.gradle.org/gradle/libs/mysql/mysql-connector-java/5.1.40/mysql-connector-java-5.1.40.jar
fi

if [ -d "/opt/teamcity/webapps/ROOT" ];
then
    # Move ROOT to use custom context
    mv /opt/teamcity/webapps/ROOT /opt/teamcity/webapps/$TEAMCITY_CONTEXT
fi

echo "Starting teamcity..."
exec /opt/teamcity/bin/teamcity-server.sh run