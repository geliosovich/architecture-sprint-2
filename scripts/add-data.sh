#!/bin/bash

docker compose exec -T mng-router mongosh --eval '
sh.shardCollection("somedb.helloDoc", { "name": "hashed" } )
';

docker compose exec -T mng-router mongosh --eval '
db = db.getSiblingDB("somedb");
for(var i = 0; i < 1000; i++)
  db.helloDoc.insertOne({age:i, name:"ly"+i});
'