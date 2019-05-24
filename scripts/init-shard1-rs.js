rs.initiate({
  _id: "shard1-rs",
  version: 1,
  members: [{
      _id: 0,
      host: "shard1-rs-a:27018"
    },
    {
      _id: 1,
      host: "shard1-rs-b:27018"
    },
    {
      _id: 2,
      host: "shard1-rs-c:27018"
    },
  ]
})
