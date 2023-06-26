LOGFILE=/ks/step4-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep redis

    docker image ls | grep nodeserver

    # cat password.txt | grep redis-password

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success