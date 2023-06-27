# What you'll learn on this lab

1. Learn how to connect a container with a network

# Tasks to be done

1. Create a docker network name `test-network`

2. Run `docker pull hello-world`

3. Create container name `hello-container` and use the image  `hello-world`

4. Connect `hello-container` with the `test-network`

5. Check that the network is exist or not all the cli command you can find in the hint section

<details>
<summary>Hint</summary>

All neccessary command in this lab

1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker build -t (image name) --build-arg (environment name)="(environment value)" .` - Use to build a docker image with an environment variable
4. `docker network create (network name)` - Use to create a network in docker
5. `docker network connect (network name) (container name)` - Use to connect the network with a docker container
6. `docker container inspect (containerid)` - Use to inspect the container network
7. `docker image ls` - Use to call all the image that exist on machine
8. `docker container ps -a` - Use to list all exist container
9. `docker run --name (container name) (image name)` - Use to create a container from image

</details>

<details>
<summary>Solution</summary>

Docker cli command

```plain
docker pull hello-world
docker run --name hello-container hello-world
docker network create test-network
docker network connect test-network hello-container
docker container inspect hello-container
```{{exec}}

</details>
