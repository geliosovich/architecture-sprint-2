docker compose exec -T mng-router mongosh --eval '
db = db.getSiblingDB("somedb");
db.helloDoc.countDocuments();
'