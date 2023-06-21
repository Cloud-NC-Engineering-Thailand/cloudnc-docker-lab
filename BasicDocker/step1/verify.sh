LOGFILE=/ks/step1-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep my-ping
    docker ps | grep ping-container

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success