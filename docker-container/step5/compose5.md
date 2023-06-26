# Why Error occur

In redis server if you remember, redis server need to be authenticate first but in our nodejs server I didn't provide the password so to fix the error we need to modify index.js to provide the password to redis

1. Click this execute command

```plain
cat > index.js <<EOF
const redis = require("redis")
const express = require('express')
const app = express()
const port = 8000
const bodyParser = require("body-parser")
const fs = require("fs")
app.use(bodyParser.json({ limit: `10mb` }));
app.use(bodyParser.urlencoded({ limit: `10mb`, extended: true }));

let redisClient = redis.createClient({
    socket:{
        host: 'redis-container',
        port: 6379,
    },
    password: fs.readFileSync(process.env.REDIS_PASS_FILE, 'utf8').trim(),
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
        return res.status(400).json({"msg":"Something Went Wrong", error})
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


```{{exec}}

2. Stop and remove all the container that is running and also remove the image of nodeserver because we have modify some code so we need to rebuild the image so the code in the image will be update

3. Rebuild an image, build and start a container

4. Let try to grab some data that we have save in redis

```plain

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{
    "key": "name",
    "value": "cloudnc"
  }' \
  http://localhost:8000/set

curl -X GET http://localhost:8000/get/name

```{{exec}}



<details>
<summary>Hint</summary>

All neccessary command in this lab
1. `touch (filename)` - Use to create a file
2. `nano (filename)` - Use to edit a file
3. `docker-compose build` - Use to build Docker images for services defined in a docker-compose.yml
4. `docker-compose up` - Use to build all the services into container
5. `docker-compose down` - Use to remove all the container in the services
4. `docker image ls` - Use to call all the image that exist on machine
5. `docker container ps -a` - Use to list all exist container
6. `docker image rm (image name)` - Use to delete a docker image with a specifig name
7. `docker container rm (container name)` - Use to delete a docker container with a specifig container
8. `docker exec -it (container name or container id) bash` - Use to access the container to run cli command

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
    secrets:
        - (Your secret name)
    environment:
        - REDIS_PASS_FILE=/run/secrets/(file name)
    command: [
        "bash", "-c",
        '
        docker-entrypoint.sh
        --requirepass "$$(cat $$REDIS_PASS_FILE)"
        '
    ]

secrets:
  (Your secret name):
    file: (file name)

networks:
  (network name):
```

</details>

<details>
<summary>Solution</summary>
```plain
cat > index.js <<EOF
const redis = require("redis")
const express = require('express')
const app = express()
const port = 8000
const bodyParser = require("body-parser")
const fs = require("fs")
app.use(bodyParser.json({ limit: `10mb` }));
app.use(bodyParser.urlencoded({ limit: `10mb`, extended: true }));

let redisClient = redis.createClient({
    socket:{
        host: 'redis-container',
        port: 6379,
    },
    password: fs.readFileSync(process.env.REDIS_PASS_FILE, 'utf8').trim(),
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
        return res.status(400).json({"msg":"Something Went Wrong", error})
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

cat > password.txt  <<EOF
redis-password
EOF

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
    secrets:
      - password
    environment:
      - REDIS_PASS_FILE=/run/secrets/password
    networks:
      - backend 

  redis-container:
    image: redis:latest
    secrets:
      - password
    environment:
      - REDIS_PASS_FILE=/run/secrets/password
    command: [
      "bash", "-c",
      '
       docker-entrypoint.sh
       --requirepass "$$(cat $$REDIS_PASS_FILE)"
      '
    ]
    ports:
      - 6379:6379
    networks:
      - backend
    volumes:
      - ./data/redis:/data

secrets:
  password:
    file: password.txt

networks:
  backend:

EOF

docker-compose down

docker-compose build

docker-compose up

```plain{{exec}}
</details>