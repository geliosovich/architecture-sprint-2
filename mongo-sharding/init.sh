#!/bin/bash
docker compose exec -T mng-cfg-srv mongosh --eval "
rs.initiate(
  {
    _id : \"config-server\",
    configsvr: true,
    members: [
      { _id : 0, host : \"mng-cfg-srv:27017\" }
    ]
  }
)"

docker compose exec -it mng-shrd-1 mongosh --eval "
rs.initiate(
    {
      _id : \"shrd-1\",
      members: [
        { _id : 0, host : \"mng-shrd-1:27017\" }
      ]
    }
)"

docker compose exec -it mng-shrd-2 mongosh --eval "
rs.initiate(
    {
      _id : \"shrd-2\",
      members: [
        { _id : 1, host : \"mng-shrd-2:27017\" }
      ]
    }
  )"

docker compose exec -it mng-router mongosh --eval "
sh.addShard( \"shrd-1/mng-shrd-1:27017\");
sh.addShard( \"shrd-2/mng-shrd-2:27017\");
sh.enableSharding(\"somedb\");
"