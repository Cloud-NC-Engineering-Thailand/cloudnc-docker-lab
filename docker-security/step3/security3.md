# What you'll learn on this lab

1. Learn how to use add a `non-root user` to secure docker image

# Tasks to be done

1. `Remove` the previous docker image and docker container

2. Update `Dockerfile` and add a user with id=3333 and username=foo

3. `Rebuild` the docker image and container with the same cli command, docker image name must me `hello-node-env` , docker container name must be `node-container-env`

<details>
<summary>Hint</summary>

All neccessary command in this lab

1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker build -t (image name) --build-arg (environment name)="(environment value)" .` - Use to build a docker image with an environment variable
4. `docker image ls` - Use to call all the image that exist on machine
5. `docker container ps -a` - Use to list all exist container
6. `docker image rm (image name)` - Use to delete a docker image with a specifig name
7. `docker container rm (container name)` - Use to delete a docker container with a specifig container


All neccessary Dockerfile syntax

1. `FROM (docker image name):(tag)` -  Specifies the starting point image for your Docker image
2. `WORKDIR (/path/to/workdir)` - Sets the folder inside the container where commands will be executed
3. `COPY (path of file or folder that you want to copy) (destination of the file or folder) ` - Moves files or folders from your computer to the container.
4. `EXPOSE (number of port that the image will be running on)` - Declares the port on which the container will listen for incoming connections.
5. `CMD ["(command line)"]` - Defines the default command to run when the container starts
6. `ENV NODE_ENV production` - Use to tell the node that our environment variable will be on production mode
7. 

```plain

ARG NODEJSPORT
ENV NODEJSPORT $NODEJSPORT

```
ARG (env name) - Use for recieving the value of the environment variable on the cli command

ENV (env name) (env value) - Use to set the environment variable name and value in the container


\8.`RUN apk add --no-cache shadow && useradd -u (userid) (username)` - Use to create a new user to a docker container

\9. User (username) - All the future command will be run by this user

</details>

<details>
<summary>Solution</summary>


Create all file 
```plain

cat > index.js <<EOF
console.log("Server start at port with environment variable " + process.env.NODEJSPORT)
EOF

cat index.js

cat > Dockerfile <<EOF
FROM node:alpine

RUN apk add --no-cache shadow && \
    useradd -u 3333 foo

USER foo

WORKDIR /app

ENV NODE_ENV production

COPY . .

ARG NODEJSPORT
ENV NODEJSPORT \$NODEJSPORT

EXPOSE \${NODEJSPORT}

CMD [ "node", "index.js" ]
EOF

cat Dockerfile
```{{exec}}

Docker cli command

```plain
docker build -t hello-node-env --build-arg NODEJSPORT="8080" .
docker run --name node-container-env hello-node-env
```{{exec}}

</details>
