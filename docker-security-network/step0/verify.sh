LOGFILE=/ks/step0-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep node-slim | grep node-alpine

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success