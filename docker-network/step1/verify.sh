LOGFILE=/ks/step4-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep hello-node
    
    docker ps -a | grep hello-container

    docker network ls | grep "test-network"

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success