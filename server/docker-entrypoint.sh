#!/bin/bash
set -e

mkdir -p $TEAMCITY_DATA_PATH/lib/jdbc $TEAMCITY_DATA_PATH/config $TEAMCITY_DATA_PATH/plugins

if [ ! -f "$TEAMCITY_DATA_PATH/lib/jdbc/postgresql-9.3-1103.jdbc41.jar" ];
then
    echo "Downloading postgress JDBC driver..."
    wget -P $TEAMCITY_DATA_PATH/lib/jdbc https://jdbc.postgresql.org/download/postgresql-9.3-1103.jdbc41.jar
fi

if [ ! -f "$TEAMCITY_DATA_PATH/plugins/teamcity.github.zip" ];
then
    echo "Downloading TeamCity.GitHub plugin..."
    wget -P $TEAMCITY_DATA_PATH/plugins http://teamcity.jetbrains.com/guestAuth/repository/download/bt398/lastest.lastSuccessful/teamcity.github.zip
fi

# Move ROOT to use custom context
mv /opt/TeamCity/webapps/ROOT /opt/TeamCity/webapps/$TEAMCITY_CONTEXT

echo "Starting teamcity..."
exec /opt/TeamCity/bin/teamcity-server.sh run