# What you'll learn on this lab

1.Understand why a network is necessary for containers

# Tasks to be done

1.Create two Docker networks named `net1` and `net2`

2.Create Dockerfile and the content in Dockerfile must be
- `FROM ubuntu:rolling`
- `RUN apt-get update && apt-get install -y iputils-ping`  
- `ENTRYPOINT ["/bin/bash"]` 

3.Build an image named `ubuntu-image`

4.Create 3 docker container using `ubuntu:rolling` image and connect it to the network by following this rule
- `ubuntu1` -> connect to `net1` -> start on port `3001:3001`
- `ubuntu2` -> connect to `net2` -> start on port `3002:3002`
- `ubuntu2.1` -> connect to `net2` -> start on port `3003:3003`

4.Check that all of the container is exist and running by using docker cli command

5.Use docker cli command and inspect the network of the container name `ubuntu2.1` and copy the IP address (a command for inspecting the IP address is already prepared)

6.Use docker cli command to access into terminal in ubuntu container name `ubuntu2`

7.Run `ping (IP address of ubuntu2.1)` and observe the response. After you satisfied, stop the ping action (to stop press ctrl+c or command+c)

8.Open a new terminal and inspect the network of the container name `ubuntu1` and copy the IP address of ubuntu1

9.Run `ping (IP address of ubuntu1)`  and observe, you will receive only one response. After that, you will not receive any more responses because they are on `different networks`

10.Exit the `ubuntu2.1` container by typing `exit` and press enter

<details>
<summary>Hint</summary>

All neccessary command in this lab

1. `docker build -t (image name) .` - Use to create a network in docker
2. `docker network create (network name)` - Use to create a network in docker
3. `docker run -t -d -p (port):(port) --network (network name) --name (container name) (image name):(tag)` - Use to create a container using image and give a parameter of port and network that will be connected
4. `docker exec -it (container name) bash` - Use to access to the ubuntu container so we can run some cli command inside the container
5. `docker network connect (network name) (container name)` - Use to connect the network with a docker container
6. `docker container inspect (container id or container name)` - Use to inspect the container network
7. `docker container inspect --format '{{ .NetworkSettings.Networks.(Your network name).IPAddress }}' (container id or container name)` - Use to inspect IP address of the container network
8. `docker image ls` - Use to list all images that exist on your current machine
9. `docker container ps -a` - Use to list all exist containers on your current machine

</details>

<details>
<summary>Solution</summary>


Create all files
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

echo "(Simply go back and refer to Task 6 for further instructions)"

```{{exec}}

</details>
