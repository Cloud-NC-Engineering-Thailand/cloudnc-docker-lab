LOGFILE=/ks/step4-verify.log
set -e # exit once any command fails

{
    date

    if !docker container inspect --format '{{ .HostConfig.NetworkMode }}' ubuntu1 2>&1 | grep -q "net1"; then
        echo "Output does not match expected message"
        exit 1
    fi
    if !docker container inspect --format '{{ .HostConfig.NetworkMode }}' ubuntu2 2>&1 | grep -q "net2"; then
        echo "Output does not match expected message"
        exit 1
    fi
    if !docker container inspect --format '{{ .HostConfig.NetworkMode }}' ubuntu2.1 2>&1 | grep -q "net2"; then
        echo "Output does not match expected message"
        exit 1
    fi

} >> ${LOGFILE} 2>&1

echo "done" # let Validator know success