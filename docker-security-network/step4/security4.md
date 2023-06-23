# What you'll learn on this lab

1. Learn how to connect a container with a network

# Tasks to be done

1. Create a docker network name `node-network`

2. Connect our `container` with the `node-network`

3. Check that the network is exist or not all the cli command you can find in the hint section

<details>
<summary>Hint</summary>

All neccessary command in this lab

1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker build -t (image name) --build-arg (environment name)="(environment value)" .` - Use to build a docker image with an environment variable
4. `docker network create (network name)` - Use to create a network in docker
5. `docker network connect (network name) (container name)` - Use to connect the network with a docker container
6. `docker container inspect (containerid)` - Use to inspect the container network


</details>

<details>
<summary>Solution</summary>


```plain
docker network create node-network
docker network connect node-network node-container
docker container inspect node-container
```{{exec}}

</details>
