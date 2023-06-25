# What you'll learn on this lab

1. Learn how to pull a `node` from `dockerhub`, make a `work directory` in a docker environment and learn how to `expose the port` that image will be listening on.

# Tasks to be done

1. Create an `index.js` file at root directory

2. Inside the `index.js` file content must be `console.log("Sever export port is 8080")`

3. Create a `Dockerfile` and `pull node:alpine`

4. Set a `work directory` to be `/app`

5. `Copy everything` to the work directory

6. Expose docker image port to be `8080`

7. Run command `node index.js`

8. Build docker image name `hello-node`

9. Build a docker container name `node-container`

<details>
<summary>Hint</summary>

All neccessary command in this lab
1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker build -t (image name) .` - Use to build a docker image
4. `docker image ls` - Use to call all the image that exist on machine
5. `docker container ps -a` - Use to list all exist container
6. `docker image rm (image name)` - Use to delete a docker image with a specifig name
7. `docker container rm (container name)` - Use to delete a docker container with a specifig container

All neccessary Dockerfile syntax
1. `FROM (docker image name):(tag)` -  Specifies the starting point image for your Docker image.
2. `WORKDIR (/path/to/workdir)` - Sets the folder inside the container where commands will be executed.
3. `COPY (path of file or folder that you want to copy) (destination of the file or folder) ` - Moves files or folders from your computer to the container.
4. `EXPOSE (number of port that the image will be running on)` - Declares the port on which the container will listen for incoming connections.
5. `CMD ["(command line)"]` - Defines the default command to run when the container starts

</details>

<details>
<summary>Solution</summary>

Create all file 

```plain

cat > index.js <<EOF
console.log("Sever export port is 8080")
EOF

cat index.js

cat > Dockerfile <<EOF
FROM node:alpine

WORKDIR /app

COPY . .

EXPOSE 8080

CMD [ "node", "index.js" ]
EOF

cat Dockerfile
```{{exec}}


Docker cli command
```plain


docker build -t hello-node .

docker run --name node-container hello-node

```{{exec}}

</details>

