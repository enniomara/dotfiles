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

host=localhost
port=54821

echo "starting server on $host:$port"

python3 ./nix/.config/nixpkgs/work/server.py "$host" "$port" &

ssh -R "$port:$host:$port" "$@" && exit
