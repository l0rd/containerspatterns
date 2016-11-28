#!/bin/bash

pyserv() {
    if [[ -n $1 ]] ; then
        port="$1"
    else
        port="8000"
    fi

    old_dir="$(pwd)"

    if [[ -n $2 ]] ; then
        cd $2
    fi

    screen -dmS pyserv${port} python -m SimpleHTTPServer ${port}

    if ! [[ "$(pwd)" == $old_dir ]] ; then
        cd $old_dir
    fi
}

PORT=8002
pyserv $PORT .
open http://localhost:$PORT/

echo "To put SimpleHTTPServer back to the foreground:
      screen -r pyserv$PORT "
# screen -ls
