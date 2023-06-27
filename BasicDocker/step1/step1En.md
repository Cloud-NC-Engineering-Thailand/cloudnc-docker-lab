# What you'll learn on this lab

1.How to create an `Image` from a `Dockerfile` and run it in a `Docker container`.


# Tasks to be done

1.Run ping command on bash to receive responses from Google. Press ctrl+c or command+c to stop and proceed to the next command: 
- Note that ping is a command used to test if your computer is able to reach the destination server.

2.Create a `Dockerfile` in the `root` directory that can execute ping google.com when we launch a container

3.Build an `Image` named `my-ping` 

4.Launch a `container` named `ping-container` from `Image` named `my-ping`

<details>
<summary>Hint</summary>

All neccessary command in this lab

1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker build -t (image name) .` - Use to build a docker image
4. `docker image ls` - Use to list all the image that exist on your current machine
5. `docker run --name (container name) (image name)` - Use to launch a container from the specified image


All neccessary Dockerfile syntax
1. `FROM (docker image name):(tag)` -  Specifies the base image for your Docker image
2. `CMD ["(command line)"]` - Defines the default command to run when the container starts

</details>


<details>
<summary>Solution</summary>


1. `touch Dockerfile`

2. `nano Dockerfile`
3. Call a Bash from Dockerhub and execute ping google.com

```plain
FROM bash
CMD ["ping", "google.com"]
```

To exit the nano editor on Windows:

    1. ctrl+x to exit from edit mode

    2. ctrl+y to save

    3. press enter

Build a Docker Image by running this following command:

Launch a container from that Docker Image by running this following command

Watch the container log and verify the result 

```plain
docker build -t my-ping .

docker image ls
```{{exec}}

Build container from DockerImage by running this following command
```plain
docker run --name ping-container my-ping
```{{exec}}

</details>