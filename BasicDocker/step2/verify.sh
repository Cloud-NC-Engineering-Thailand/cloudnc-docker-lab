LOGFILE=/ks/step2-verify.log
set -e # exit once any command fails

{
    date

    docker image ls | grep my-ping | grep -v local-registry | grep 1.0.1

    docker image ls | grep local-registry:5000/my-ping | grep 1.0.1

    curl http://local-registry:5000/v2/my-ping/tags/list -k | grep my-ping | grep 1.0.1

    rm /tmp/curl || true

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success