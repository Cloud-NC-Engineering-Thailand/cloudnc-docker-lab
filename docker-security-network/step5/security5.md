# What you'll learn on this lab

1. Learn why we need a network for container 

# Tasks to be done

1. Create a docker network name `net1` and `net2`

2. Remove all the content in Dockerfile and rewrite the Dockerfile by this content
`FROM ubuntu:rolling`
`RUN apt-get update && apt-get install -y iputils-ping`  
`ENTRYPOINT ["/bin/bash"]` 

3. Build an image that is name `ubuntu-image`

3. Create a 3 docker container using ubuntu:rolling image and connect it to the network by following this rule
`ubuntu1` -> connect to `net1` -> start on port `3001:3001`
`ubuntu2` -> connect to `net2` -> start on port `3002:3002`
`ubuntu2.1` -> connect to `net2` -> start on port `3003:3003`

4. Check that all of the container is exist all not with the docker cli command

5. Use docker cli command and inspect the network of the container name `ubuntu2.1` and copy the ipaddress (command for inspect only ipaddress is already prepare)

6. Use docker cli command to get into terminal in ubuntu container name `ubuntu2`

7. Run `ping (ipaddress of ubuntu2.1)` you will see that we will get a response back and after that stop the ping action (if you want to stop press ctrl+c or command+c)

8. Open new terminal and inspect the network of the container name `ubuntu1` and copy the ipaddress

9. Now Run `ping (ipaddress of ubuntu1)` you will get only once response and after that you will not get any response because there are on the `different network`

10. Exit the `ubuntu2.1` container by typing `exit` and press enter

<details>
<summary>Hint</summary>

All neccessary command in this lab

1. `docker build -t (image name) .` - Use to create a network in docker
2. `docker network create (network name)` - Use to create a network in docker
3. `docker run -t -d -p (port):(port) --network (network name) --name (container name) (image name):(tag)` - Use to create a container using image and give a parameter of port and network that will be connected
4. `docer exit -it (container name) bash` - Use to enter to the ubuntu container and let us can run the cli command in terminal
5. `docker network connect (network name) (container name)` - Use to connect the network with a docker container
6. `docker container inspect (container id or container name)` - Use to inspect the container network
7. `docker container inspect --format '{{ .NetworkSettings.Networks.(Your network name).IPAddress }}' (container id or container name)` - Use to inspect IPaddress of the container network
8. `docker image ls` - Use to call all the image that exist on machine
9. `docker container ps -a` - Use to list all exist container

</details>

<details>
<summary>Solution</summary>


Create all file 
```plain

cat > Dockerfile <<EOF
FROM ubuntu:rolling

RUN apt-get update && apt-get install -y iputils-ping

ENTRYPOINT ["/bin/bash"]

EOF

cat Dockerfile


```{{exec}}

Docker cli command

```plain


docker network create net1
docker network create net2

docker build -t ubuntu-image .

docker run -t -d -p 3001:3001 --network net1 --name ubuntu1 ubuntu-image
docker run -t -d -p 3002:3002 --network net2 --name ubuntu2 ubuntu-image
docker run -t -d -p 3003:3003 --network net2 --name ubuntu2.1 ubuntu-image

docker container inspect --format '{{ .NetworkSettings.Networks.net1.IPAddress }}' ubuntu1
docker container inspect --format '{{ .NetworkSettings.Networks.net2.IPAddress }}' ubuntu2
docker container inspect --format '{{ .NetworkSettings.Networks.net2.IPAddress }}' ubuntu2.1

echo (All you need to do after this just go back and look at task to be done in number 6)

```{{exec}}

</details>
