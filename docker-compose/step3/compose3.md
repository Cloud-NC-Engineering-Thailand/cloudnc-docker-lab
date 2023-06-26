# What you'll learn on this lab

1. You will learn how to use volumes with Docker Compose to store data persistently, even when the container is down

# Tasks to be done


1. You need to edit `docker-compose.yml` add this line of code to `redis-container`

```plain

volumes:
    - (path to store the data)

```

In this case, we will mount the path `./data/redis:/data` this means that our Redis data will be stored in the data/redis folder, and all the files containing the data will be inside the redis folder

After you have change in `docker-compose.yml` try to save the data to redis and then run `docker-compose down` and run `docker-compose up` and run `curl -X GET http://localhost:8000/get/(your key name)` in terminal, you will see that now the data is not lost.

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
    command: (Your command line that you want to execute)
    volumes:
      - (host directory):(target directory for container)
  
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

    
networks:
  backend:
EOF

```{{exec}}

</details>