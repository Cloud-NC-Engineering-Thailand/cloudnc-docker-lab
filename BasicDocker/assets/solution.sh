#!/bin/bash

cat > /root/Dockerfile <<EOF
FROM bash
CMD ["ping", "google.com"]
EOF

podman build -t my-ping .

podman run -d --name ping-container my-ping

podman tag my-ping local-registry:5000/my-ping

podman push local-registry:5000/my-ping

podman tag my-ping my-ping:1.0.1
podman tag my-ping local-registry:5000/my-ping:1.0.1

podman push local-registry:5000/my-ping:1.0.1