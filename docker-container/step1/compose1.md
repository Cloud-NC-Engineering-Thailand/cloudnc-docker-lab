# What you'll learn on this lab

1. Learn how to use docker compose to define multi-container at the same time

# Tasks to be done

1. Click Execute this block of command this will create a simple nodejs server that connect to the redis database


```plain

cat > index.js <<EOF
const redis = require("redis")
const express = require('express')
const app = express()
const port = 8000
const bodyParser = require("body-parser")

app.use(bodyParser.json({ limit: `10mb` }));
app.use(bodyParser.urlencoded({ limit: `10mb`, extended: true }));

let redisClient = redis.createClient({
    socket:{
        host: 'redis-container',
        port: 6379,
    },
    legacyMode:true
})
redisClient.connect().catch(console.error)
redisClient.on('error', err => console.log('Redis Server Error', err));
redisClient.on("connect", function() {
  console.log("Connected")
})

app.get('/get/:key', async (req, res) => {
  const { key } = req.params;

  try {
    await redisClient.get(key, async (error, data) => {
      if(error) {
        return res.status(400).json({"msg":"Something Went Wrong"})
      }
      return res.status(200).json({key, data:JSON.parse(data)})
    })

  } catch (err) {
    console.error('Error getting value from Redis:', err);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});

app.post('/set', async (req, res) => {
  const { key, value } = req.body;
  try {
    await redisClient.setEx(key, 60*60, JSON.stringify(value));

    return res.status(200).json({ message: 'Value set in Redis' });
  } catch (err) {
    console.error('Error setting value in Redis:', err);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});

app.get('/', (req, res) => {
  return res.status(200).json({msg:"hello"})
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
EOF

cat index.js

npm init -y

```{{execute}}

2. Install Docker compose
```plain

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version

```{{execute}}




2. Create a `Dockerfile` and the content must be following by this 
    - Pull `node:alpine`
    - Set work directory to be at `/app`
    - Copy only the `package.json` to de
    - RUN `npm install` in work directory `/app`
    - Copy everythings to work directory `/app`
    - `Expose` port to be `8080`
    - Execute the command `node index.js`

3. Create a `docker-compose.yml`

4. Inslide `docker-compose.yml` use `version 3.9`

5. Create 2 services `node-container` and `redis-container`


6. For service `redis-container` 
    - Use image name `redis:latest`
    - Start on port `6379:6379`
    - Connect to network name `backend`

7. For service `node-container` 
    - Use image name `nodeserver`
    - Give a build context and path to Dockerfile
    - Start on port `8000:8000`
    - Make it start depends on `redis-container`
    - Connect to network name `backend`

8. Run docker cli command to build and start the container

<details>
<summary>Hint</summary>

All neccessary command in this lab
1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker compose build` - Use to build Docker images for services defined in a docker-compose.yml
4. `docker compose up` - Use to build all the services into container
5. `docker compose down` - Use to remove all the container in the services
4. `docker image ls` - Use to call all the image that exist on machine
5. `docker container ps -a` - Use to list all exist container
6. `docker image rm (image name)` - Use to delete a docker image with a specifig name
7. `docker container rm (container name)` - Use to delete a docker container with a specifig container

All neccessary Dockerfile syntax
1. `FROM (docker image name):(tag)` -  Specifies the starting point image for your Docker image
2. `WORKDIR (/path/to/workdir)` - Sets the folder inside the container where commands will be executed
3. `COPY (path of file or folder that you want to copy) (destination of the file or folder) ` - Moves files or folders from your computer to the container
4. `RUN` - Used to execute commands during the image build process. It allows you to run any command that you would typically run on a command line inside the container
4. `EXPOSE (number of port that the image will be running on)` - Declares the port on which the container will listen for incoming connections
5. `CMD ["(command line)"]` - Defines the default command to run when the container starts

All neccessary docker-compose.yml syntax
```plain
version: (version number)

services:
  (container name):
    image: (image name)
    build:
      context: (path of the folder to be build)
      dockerfile: (path to Dockerfile)
    ports:
      - (port number):(port number)
    depends_on:
      - (if this container name is start this container will start after)
    networks:
      - (network name)
  
networks:
  (network name):
```

</details>


<details>
<summary>Solution</summary>

Create all file 

```plain

cat > index.js <<EOF
const redis = require("redis")
const express = require('express')
const app = express()
const port = 8000
const bodyParser = require("body-parser")

app.use(bodyParser.json({ limit: `10mb` }));
app.use(bodyParser.urlencoded({ limit: `10mb`, extended: true }));

let redisClient = redis.createClient({
    socket:{
        host: 'redis-container',
        port: 6379,
    },
    legacyMode:true
})
redisClient.connect().catch(console.error)
redisClient.on('error', err => console.log('Redis Server Error', err));
redisClient.on("connect", function() {
  console.log("Connected")
})

app.get('/get/:key', async (req, res) => {
  const { key } = req.params;

  try {
    await redisClient.get(key, async (error, data) => {
      if(error) {
        return res.status(400).json({"msg":"Something Went Wrong"})
      }
      return res.status(200).json({key, data:JSON.parse(data)})
    })

  } catch (err) {
    console.error('Error getting value from Redis:', err);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});

app.post('/set', async (req, res) => {
  const { key, value } = req.body;
  try {
    await redisClient.setEx(key, 60*60, JSON.stringify(value));

    return res.status(200).json({ message: 'Value set in Redis' });
  } catch (err) {
    console.error('Error setting value in Redis:', err);
    res.status(500).send({ error: 'Internal Server Error' });
  }
});

app.get('/', (req, res) => {
  return res.status(200).json({msg:"hello"})
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})
EOF

npm init -y

cat > docker-compose.yml <<EOF
version: '3.9'
services: 

  node-container:
    image: nodeserver
    build: 
      context: .
      dockerfile: Dockerfile
    ports:
      - 8000:8000
    depends_on:
      - redis-container
    networks:
      - backend 

  redis-container:
    image: redis:latest
    ports:
      - 6379:6379
    networks:
      - backend
    
networks:
  backend:
EOF


cat > Dockerfile <<EOF
FROM node:alpine

WORKDIR /app

COPY package*.json ./

RUN --mount=type=cache,target=/app/.npm \
  npm set cache /app/.npm && \
  npm install

COPY . .

EXPOSE 8000

CMD ["node", "index.js"]
EOF


```{{exec}}

Docker cli command
```plain

docker-compose build

docker-compose up

```{{exec}}

</details>

