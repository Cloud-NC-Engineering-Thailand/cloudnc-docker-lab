LOGFILE=/ks/step2-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep hello-node
    
    docker ps -a | grep node-container

    if !docker run hello-node 2>&1 | grep -q "Server start at port with environment variable 8080"; then
        echo "Output does not match expected message"
        exit 1
    fi


} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success