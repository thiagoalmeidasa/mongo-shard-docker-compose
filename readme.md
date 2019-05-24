# Mongo Sharded Cluster with Docker Compose

A simple sharded Mongo Cluster with a replication factor of 2 running in `docker` using `docker-compose`.

Designed to be quick and simple to get a local or test environment up and running. Needless to say... DON'T USE THIS IN PRODUCTION!

Heavily inspired by [https://github.com/chefsplate/mongo-shard-docker-compose](https://github.com/chefsplate/mongo-shard-docker-compose)

### Mongo Components

- Config Server (3 member replica set): `config01`,`config02`,`config03`
- 1 Shards with 3 replica sets
  - `shard01a`,`shard01b`,`shard01c`
- 1 Router (mongos): `router`
- (TODO): DB data persistence using docker data volumes

### First Run (initial setup)

**Start all of the containers** (daemonized)

```
docker-compose up -d
```

**Initialize the replica sets (config server and shards) and router**

```
sh init.sh
```

This script has a `sleep 25` to wait for the config server and shards to elect their primaries before initializing the router

**Verify the status of the sharded cluster**

```
docker-compose exec router mongo
mongos> sh.status()
--- Sharding Status ---
  sharding version: {
        "_id" : 1,
        "minCompatibleVersion" : 5,
        "currentVersion" : 6,
        "clusterId" : ObjectId("5ce7a797c079e4b3631fd97d")
  }
  shards:
        {  "_id" : "shard1-rs",  "host" : "shard1-rs/shard1-rs-a:27018,shard1-rs-b:27018,shard1-rs-c:27018",  "state" : 1 }
  active mongoses:
        "4.0.9" : 1
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
        Failed balancer rounds in last 5 attempts:  0
        Migration Results for the last 24 hours:
                No recent migrations
  databases:
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }
```

### Normal Startup

The cluster only has to be initialized on the first run. Subsequent startup
can be achieved simply with `docker-compose up` or `docker-compose up -d`

### Accessing the Mongo Shell

Its as simple as:

```
docker-compose exec router mongo
```

### Resetting the Cluster

To remove all data and re-initialize the cluster, make sure the containers are
stopped and then:

```
docker-compose rm -v
```

Execute the **First Run** instructions again.
