# What you'll learn on this lab

1. You will learn how to use volumes with Docker Compose to store data persistently, even when the container is down

# Tasks to be done

(we need to add new config to our redis database if anybody didn't create redis.conf yet, follow this step; Create a folder name `config` and inside folder config make a file name `redis.conf` copy the config from this repository <a href="https://github.com/chitsanuponjate/redis-config/tree/main"> into `redis.conf`)

1. You need to edit `docker-compose.yml` add this line of code to `redis-container`

```plain

volumes:
    - (path to store the data)

```

In this case, we will mount the path `./data/redis:/data` and we also need to mount the config path to be `./config/redis.conf:/redis.conf`, this means that our Redis data will be stored in the data/redis folder, and all the files containing the data will be inside the redis folder

After you have mount the data and the redis config path you need to run the `command` into `redis-server` to let the `redis-server` know that we going to have a new config to `redis` command for tell redis-server `redis-server /redis.conf`

After you have change in `docker-compose.yml` try to save the data to redis and then run `docker-compose down` and run `docker-compose up` and run `curl -X GET http://localhost:8000/get/(your key name)` in terminal, you will see that now the data is not lost.

```plain

curl -X POST -H "Content-Type: application/json" -d '{"key": "name","value": "cloudnc"}' http://localhost:8000/set

curl -X GET http://localhost:8000/get/name

```

<details>
<summary>Hint</summary>

All neccessary docker-compose.yml syntax
```plain
version: (version number)

services:
  (container name):
    image: (image name)
    build:
      context: (path of the folder to be build)
      dockerfile: (path to Dockerfile)
    ports:
      - (port number):(port number)
    depends_on:
      - (if this container name is start this container will start after)
    networks:
      - (network name)
    volumes:
      - (host directory):(target directory for container)
    command: (Your command line that you want to execute)
  
networks:
  (network name):
```

</details>

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
    volumes:
      - ./data/redis:/data
      - ./config/redis.conf:/redis.conf
    command: redis-server /redis.conf
    
networks:
  backend:
EOF

```{{exec}}

</details>