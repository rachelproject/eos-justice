#!/bin/bash
# Stop the containers if they are running
sudo podman stop eec-http 2> /dev/null
sudo podman stop eec-mysql 2> /dev/null
# Remove existing copies of the container and pod
# Note: This is work around to the following bug, in the future this might not be necessary
# https://github.com/containers/libpod/issues/3759
sudo podman rm eec-http 2> /dev/null
sudo podman rm eec-mysql 2> /dev/null
sudo podman pod rm eec 2> /dev/null
# None of the commands after this point are expected to fail
set -e
# Recreate the pod and containers
# Note: This is work around to the following bug, in the future this might not be necessary
# https://github.com/containers/libpod/issues/3759
sudo podman pod create --publish 9006:80 --name eec
sudo podman create --pod eec --name eec-mysql --mount
type=bind,src=/path/to/data,dst=/var/lib/mysql -e MYSQL_ROOT_PASSWORD=QCBDLNa6 -e
MYSQL_DATABASE=eec -e MYSQL_USER=eec -e MYSQL_PASSWORD=EbJEBWmE eec-mysql:5.0.0.5
sudo podman create --pod eec --name eec-http eec-http:5.0.0.5-endlessos
# Start the containers
sudo podman start eec-mysql
sudo podman start eec-http
