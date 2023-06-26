LOGFILE=/ks/step4-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep redis

    docker image ls | grep nodeserver

    cat password.txt | grep redis-password

    docker ps -a | grep node-container

    docker ps -a | grep redis-container

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success