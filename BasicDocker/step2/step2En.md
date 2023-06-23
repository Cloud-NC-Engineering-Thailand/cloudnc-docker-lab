# What you'll learn on this lab

1. Learn How to create a `Tag Docker Image` in order to select the desired `Image` for `pushing` to Dockerhub or other containers. In this case, we will push it to our own machine. Additionally, everyone is required to add a `Tag Version` to the `Image`.

# Tasks to be done

1. Tag the `Image` named `my-ping` and change the `Image` name to `local-registry:5000/my-ping:1.0.1`, including adding a `Tag Version` to the `Image`.

2. Check if the `Image` with `Tag Version` is exists on our machine.

3. Push an Image that has a `Tag Version`.

<details>
<summary>Hint</summary>

All neccessary command in this lab

1. `docker tag (image name) (tag name):(tag version)` - Use to build a docker image
2. `docker image ls` - Use to call all the image that exist on machine
3. `docker push (tag name)` - Use to push a tag image to Dockerhub or other containers

All neccessary Dockerfile syntax
1. `FROM (docker image name):(tag)` -  Specifies the starting point image for your Docker image.
2. `CMD ["(command line)"]` - Defines the default command to run when the container starts.

</details>

<details>
<summary>Solution</summary>

```plain
docker tag my-ping local-registry:5000/my-ping:1.0.1

docker image ls

docker push local-registry:5000/my-ping:1.0.1
```{{exec}}

</details>
