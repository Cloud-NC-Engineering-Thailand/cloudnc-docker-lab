# What you'll learn on this lab

1. You will learn how to use volumes with Docker Compose to store data persistently, even when the container is down

# Tasks to be done

1. You need to create the `redis.conf` file at path `config/redis.conf` in this lab I already provided you a config

```plain

mkdir config

cd config

cat > rediis.conf <<EOF

bind 0.0.0.0
protected-mode no

port 6379

tcp-backlog 511

timeout 0

tcp-keepalive 300

daemonize no

supervised no

pidfile /var/run/redis_6379.pid
loglevel notice

logfile ""

databases 16

always-show-logo yes

save ""

stop-writes-on-bgsave-error yes

rdbcompression yes

rdbchecksum yes

dbfilename dump.rdb

rdb-del-sync-files no
dir ./

replica-serve-stale-data yes

replica-read-only yes

repl-diskless-sync no

repl-diskless-sync-delay 5

repl-diskless-load disabled

repl-disable-tcp-nodelay no

replica-priority 100

acllog-max-len 128

lazyfree-lazy-eviction no
lazyfree-lazy-expire no
lazyfree-lazy-server-del no
replica-lazy-flush no


lazyfree-lazy-user-del no

oom-score-adj no

oom-score-adj-values 0 200 800



appendonly yes

appendfilename "appendonly.aof"

appendfsync everysec

no-appendfsync-on-rewrite no


auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb

aof-load-truncated yes

aof-use-rdb-preamble yes


lua-time-limit 5000

slowlog-log-slower-than 10000

slowlog-max-len 128

latency-monitor-threshold 0

notify-keyspace-events ""

hash-max-ziplist-entries 512
hash-max-ziplist-value 64

list-max-ziplist-size -2

list-compress-depth 0

set-max-intset-entries 512

zset-max-ziplist-entries 128
zset-max-ziplist-value 64

hll-sparse-max-bytes 3000

stream-node-max-bytes 4096
stream-node-max-entries 100

activerehashing yes

client-output-buffer-limit normal 0 0 0
client-output-buffer-limit replica 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60

hz 10

dynamic-hz yes

aof-rewrite-incremental-fsync yes

rdb-save-incremental-fsync yes

jemalloc-bg-thread yes

vm.overcommit_memory 1
EOF

cd ..

```{{exec}}

2. You need to edit `docker-compose.yml` add this line of code to `redis-container`

```plain

volumes:
    - (path to store the data)

```

In this case, we will mount the path `./data/redis:/data` and you have to mount the config path also and the config path is `./config/redis.conf:/redis.conf`  This means that our Redis data will be stored in the data/redis folder, and all the files containing the data will be inside the redis folder

To implement our new redis config you have to add a `command` into a `redis-container` and that command that going to be execute should be `redis-server /redis.conf`

After you have change in `docker-compose.yml` try to save the data to redis and then run `docker-compose down` and run `docker-compose up` and run `curl -X GET http://localhost:8000/get/(your key name)` in terminal, you will see that now the data is not lost.


<details>
<summary>Solution</summary>

```plain

cat > docker-compose.yml <<EOF
version: '3.9'
services: 
  
  node-container:
    image: nodeserver
    build: 
      context: .
      dockerfile: Dockerfile
    ports:
      - 8000:8000
    depends_on:
      - redis-container
    networks:
      - backend 

  redis-container:
    image: redis:latest
    ports:
      - 6379:6379
    networks:
      - backend
    command: 
      - redis-server /redis.conf
    volumes:
      - ./data/redis:/data
      - ./config/redis.conf:/redis.conf

    
networks:
  backend:
EOF

```{{exec}}

</details>