LOGFILE=/ks/step2-verify.log
set -e # exit once any command fails

{
    docker image ls | grep redis

    docker image ls | grep nodeserver

    docker ps -a | grep node-container

    docker ps -a | grep redis-container

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success