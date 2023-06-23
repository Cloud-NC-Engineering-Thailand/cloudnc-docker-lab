# What you'll learn on this lab

1. How to scan docker image vulnerability and severity

2. Use trivy to for security, issue, and targets where it can find those issue, in this scenario we will compare between `alpine` and `slim`

3. Why most of the time we must use `alpine` tag instead of other


# Tasks to be done

1. Install trivy using docker by running this following command `docker run aquasec/trivy` 

2. Pull the docker image of `node:alpine` and `node:slim` by using `docker pull (image:tag)`

3. Use trivy to check for the vulnerability, issue and severity by running this command `docker run -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy image node-slim`


# Result 
In the end you will see that for the `node:slim` there are a ton of issue coming out from terminal but in the other hand `node:alpine` have only 1 issue coming out from terminal.


<details>
<summary>Solution</summary>

```plain
docker run aquasec/trivy

docker pull node:slim

docker pull node:alpine

docker run -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy image node-slim

docker run -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy image node-alpine


```{{exec}}

</details>
