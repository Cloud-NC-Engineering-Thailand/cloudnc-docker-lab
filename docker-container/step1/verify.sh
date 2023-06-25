LOGFILE=/ks/step2-verify.log
set -e # exit once any command fails

{
    date

    docker ps -a | grep node-redis

    docker image ls | grep redis

    docker image ls | grep nodeserver

0
} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success