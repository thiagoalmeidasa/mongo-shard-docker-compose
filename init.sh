#!/bin/bash

docker-compose up -d
docker-compose exec config01 sh -c "mongo --port 27017 < /scripts/init-configserver.js"
docker-compose exec shard1-rs-a sh -c "mongo --port 27018 < /scripts/init-shard1-rs.js"
sleep 25
docker-compose exec router sh -c "mongo < /scripts/init-router.js"
