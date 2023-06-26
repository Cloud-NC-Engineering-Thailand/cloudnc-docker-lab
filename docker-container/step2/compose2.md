# Let understand what we have build

We have created a very simple server that can receive requests to save data to a Redis database and retrieve data from it

Let do some example so you can understand what we are doing, first of all open a new terminal and make sure the container is running by typing `docker-compose up`

Let save some data into the database by running the following command in the terminal

```plain

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "key": "name",
    "value": "cloudnc"
  }' \
  http://localhost:8000/set

```{{execute}}

If you receive the message "Value set in Redis," it means the data has been successfully saved

So let try to get our data by running this command in terminal

``plain

curl -X GET http://localhost:8000/get/name

```{{execute}}

If you receive the response {"key":"name","data":"cloudnc"}, it means you have successfully retrieved the data from Redis

# But there are still some problem

If the container is completely removed, the data that we saved in Redis will also be removed

To see this problem in action, let's remove the container. Stop the container and type `docker-compose down` in the terminal

After that, start the container again by type `docker-compose up` in the terminal
```plain

curl -X GET http://localhost:8000/get/name

```{{execute}}

You will receive a response that is not {"key":"name","data":"cloudnc"}. This happens because the container was removed along with the data stored in Redis

So in the next lab I will show you how to fix this problem