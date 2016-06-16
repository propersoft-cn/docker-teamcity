Propersoft TeamCity Server in Docker
====================================

```
# Pull images
$ docker pull postgres
$ docker pull propersoft/docker-teamcity:server

# Use this image with postgres
$ POSTGRES_PASSWORD=mysecretpassword
$ SETUP_TEAMCITY_SQL="create role teamcity with login password 'teamcity';create datebase teamcity owner teamcity;"
# Start an official docker postgres instance
$ docker run --name some-postgres -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -p 5432:5432 -d postgres
# Create the database using psql
$ docker run -it --link some-postgres:postgres --rm -e "SETUP_TEAMCITY_SQL=$SETUP_TEAMCITY_SQL" -e "PGPASSWORD=$POSTGRES_PASSWORD" postgres bash -c 'exec echo $SETUP_TEAMCITY_SQL |psql -h postgres -U postgres'

# Linking TeamCity server to the postgres image
$ docker run --name tc-server --link some-postgres:postgres -v /home/ds/teamcity:/var/lib/teamcity -p 9090:8111 -d propersoft/docker-teamcity:server
```
