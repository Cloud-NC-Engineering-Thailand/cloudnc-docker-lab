# What you'll learn on this lab

1. How to create an `Image` from a `Dockerfile` and run it in a `Docker container`.


# Tasks to be done

1. Run the following command on bash to receive responses from Google. Press ctrl+c or command+c to stop and proceed to the next command:
(ping is a command used to test the internet status of a computer or destination server).


2. Create a `Dockerfile` in the `root` directory 

3. Build `Image` named `my-ping` that can execute `ping google.com` when we start the image
4. Build `container` named `ping-container` from `Image` named `my-ping`

<detail>
<summary>Hint</summary>

All neccessary command in this lab

1. `touch (filename)` - Use to create a file

2. `nano (filename)` - Use to edit a file
3. `docker build -t (image name) .` - Use to build a docker image
4. `docker image ls` - Use to call all the image that exist on machine
5. `docker run --name (container name) (image name)` - Use to create a container from image
</detail>


<detail>
<summary>Solution</summary>


1. `touch Dockerfile`

2. `nano Dockerfile`
3. Call a Bash from Dockerhub and execute ping google.com

```plain
FROM bash
CMD ["ping", "google.com"]
```

To exit the nano editor on Windows:

    1. ctrl+x

    2. ctrl+y to save

    3. press enter

Build DockerImage by running this following command 

```plain
docker build -t my-ping .

docker image ls
```{{exec}}

Build container from DockerImage by running this following command
```plain
docker run --name ping-container my-ping
```{{exec}}

</detail>