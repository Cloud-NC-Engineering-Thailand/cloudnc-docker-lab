# What you'll learn on this lab

1.Learn how to use an `environment variable` in Dockerfile and make the app can use that environment variable

# Tasks to be done

1.Update an `index.js` file at root directory

2.Inside the `index.js` file content must be `console.log("Server start at port with environment variable " + process.env.NODEJSPORT)`

3.Update Dockerfile set the `NODE_ENV` to `production` by writing this in Dockerfile `ENV NODE_ENV production` this will let the node know that we want the environment to be on production mode

4.Declare the `environment variable` in `Dockerfile` name `NODEJSPORT` and change the `EXPOSE 8080` to `EXPORT ${NODEJSPORT}` all of the syntax you can find in the hint section

5.Build docker image name `hello-node-env` and give a environment variable value in cli name `NODEJSPORT` to be `5000`

6.Build a docker container name `node-container-env`

<details>
<summary>Hint</summary>

All neccessary command in this lab
1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker build -t (image name) --build-arg (environment name)="(environment value)" .` - Use to build a docker image with an environment variable
4. `docker image ls` - Use to list all images that exist on your current machine
5. `docker container ps -a` - Use to list all exist containers on your current machine
6. `docker image rm (image name)` - Use to delete a docker image with a specified name
7. `docker container rm (container name)` - Use to delete a docker container with a specified container


All neccessary Dockerfile syntax
1. `FROM (docker image name):(tag)` -  Specifies the base image for your Docker image
2. `WORKDIR (/path/to/workdir)` - Set the folder inside the container where commands will be executed
3. `COPY (path of file or folder that you want to copy) (destination of the file or folder) ` - Moves files or folders from your computer to the container
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
</details>

<details>
<summary>Solution</summary>


Create all files
```plain

cat > index.js <<EOF
console.log("Server start at port with environment variable " + process.env.NODEJSPORT)
EOF

cat index.js

cat > Dockerfile <<EOF
FROM node:alpine

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
