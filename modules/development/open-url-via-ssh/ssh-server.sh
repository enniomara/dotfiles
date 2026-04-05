#!/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail

finish () {
    echo "bye"
    local pids
    pids=$(jobs -pr)
    [ -n "$pids" ] && kill "$pids"
}

trap finish EXIT

serverPath=$1
shift
host=$1
shift
port=$1
shift

echo "starting server on $host:$port"

python3 "$serverPath" "$host" "$port" &

ssh -R "$port:$host:$port" "$@" && exit
