#!/bin/sh
launcher_dir="$(dirname "$0")"
source "$launcher_dir/launcher_funcs.sh"

MONGODB_CONTAINER_NAME="mongodb"

# Run mongodb
cid=$(docker run -d --name ${MONGODB_CONTAINER_NAME} mongo:3.2.10)

# Wait until it has started
wait_until_container_is_running ${cid}
if ! container_is_running ${cid}; then
    echo "ERROR: Timeout waiting for mongodb container to start."
    exit 1
else
    echo "Mongodb has started and is running in container ${cid}"
fi 

# Smoke test mongodb to confirm it'working fine
check_mongod_is_fine ${cid}

# Run our application
cid=$(docker run -d --link ${MONGODB_CONTAINER_NAME}:mongodb containerslanguages/rust)

# Wait until it has started
wait_until_container_is_running ${cid}
if ! container_is_running ${cid}; then
    echo "ERROR: Timeout waiting for the rust container to start."
    exit 1
else
    echo "Our rust app has started and is running in container ${cid}"
fi 
