LOGFILE=/ks/step2-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep redis

    docker image ls | grep nodeserver

    cat password.txt | grep helloredis

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success