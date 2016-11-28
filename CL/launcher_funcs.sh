#!/bin/sh

container_is_running() {
  CONTAINER_ID=${1}  
  if [ "$(docker ps -qa -f "status=running" -f "id=${CONTAINER_ID}" | wc -l)" -eq 0 ]; then
    return 1
  else
    return 0
  fi
}

wait_until_container_is_running() {
  CONTAINER_ID=${1}
  CONTAINER_START_TIMEOUT=10

  ELAPSED=0
  until container_is_running ${CONTAINER_ID} || [ ${ELAPSED} -eq "${CONTAINER_START_TIMEOUT}" ]; do
    sleep 1
    ELAPSED=$((ELAPSED+1))
  done
}

check_mongod_is_fine() {
  CONTAINER_ID=${1}
  if [ "$(docker exec ${CONTAINER_ID} pidof mongod | wc -l)" -eq 0 ]; then
    return 1
  else
    return 0
  fi
}
