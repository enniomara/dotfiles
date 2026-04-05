#!/bin/bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail

host=$1
port=$2
payload=$3

payload="{\"type\": \"url\", \"open\": \"$3\"}"
echo "$payload"

echo -n "$payload" | nc -N "$host" "$port"

