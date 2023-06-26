LOGFILE=/ks/step-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep hello-node
    
    docker ps -a | grep node-container

    if ! docker run hello-node 2>&1 | grep -q "Sever export port is 8080"; then
        echo "Output does not match expected message"
        exit 1
    fi



} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success