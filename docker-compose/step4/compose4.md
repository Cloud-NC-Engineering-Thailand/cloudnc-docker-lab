# What you'll learn on this lab

1. You will learn how to use docker secret to manage the sensitive data and make your docker image more secure

2. In this case you will learn how to use a docker secret to make a redis database need to be authentication before the command execute

# Tasks to be done

1. Create a file name `password.txt` content of the file must be `redis-password` (it's up to you but in this case I want it to be simple and easy to remember, make sure that when you submit the content in the file is `redis-password`)

2. Update the `docker-compose.yml` add ths line of code above the networks
```plain
secrets:
  (Your secret name):
    file: (file name)

networks:
  (network name):
```

3. Edit `docker-compose.yml` and add this line of code into `redis-container` image, to running multiple command in `docker-compose.yml` you need to write this syntax that given below
```plain
secrets:
    - (Your secret name)
environment:
    - REDIS_PASS_FILE=/run/secrets/(file name)
command: >
    sh -c "redis-server /redis.conf 
    --requirepass $$(cat $$REDIS_PASS_FILE)"
```
       

4. After you have done task 1-3 stop and `remove all` the container that is running and `start a new container` you will recieve some error in nodejs server but that fine we will fix that in the next lab

5. Open a new terminal and access to the redis container and type `redis-cli` after that type `ping` the response should be `pong` but in this case we tell the redis that only the user that is already authenticate can only run cli command in the terminal

6. You need to use `AUTH (password)` in redis terminal first before running any cli command and if your password is correct now if you type ping and hit enter you will receive pong that mean you are ready to go.

<details>
<summary>Hint</summary>

All neccessary command in this lab
1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker-compose build` - Use to build Docker images for services defined in a docker-compose.yml
4. `docker-compose up` - Use to build all the services into container
5. `docker-compose down` - Use to remove all the container in the services
4. `docker image ls` - Use to call all the image that exist on machine
5. `docker container ps -a` - Use to list all exist container
6. `docker image rm (image name)` - Use to delete a docker image with a specifig name
7. `docker container rm (container name)` - Use to delete a docker container with a specifig container
8. `docker exec -it (container name or container id) bash` - Use to access the container to run cli command

All neccessary docker-compose.yml syntax

```plain

version: (version number)

services:
  (service name):
    container_name: (container name)
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
    secrets:
        - (Your secret name)
    environment:
        - REDIS_PASS_FILE=/run/secrets/(file name)
    command: (This is how we run a multiple command in docker-compose)
      sh -c "redis-server /redis.conf 
      --requirepass $$(cat $$REDIS_PASS_FILE)"
secrets:
  (Your secret name):
    file: (file name)

networks:
  (network name):
```{{exec}}

</details>

<details>
<summary>Solution</summary>

```plain

cat > password.txt  <<EOF
redis-password
EOF

cat > docker-compose.yml <<EOF
version: '3.9'
services: 
  
  node-container:
    container_name: node-container
    image: nodeserver
    build: 
      context: .
      dockerfile: Dockerfile
    ports:
      - 8000:8000
    depends_on:
      - redis-container
    secrets:
      - password
    environment:
      - REDIS_PASS_FILE=/run/secrets/password
    networks:
      - backend 

  redis-container:
    container_name: redis-container
    image: redis:latest
    secrets:
      - password
    environment:
      - REDIS_PASS_FILE=/run/secrets/password
    command: >
      sh -c "redis-server /redis.conf 
      --requirepass $$(cat $$REDIS_PASS_FILE)"
    ports:
      - 6379:6379
    networks:
      - backend
    volumes:
      - ./data/redis:/data
      - ./config/redis.conf:/redis.conf

secrets:
  password:
    file: password.txt

networks:
  backend:

EOF

docker-compose down

docker-compose build

docker-compose up

```{{exec}}


</details>