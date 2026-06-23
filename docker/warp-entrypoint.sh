#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

warp-svc &

until warp-cli --accept-tos status >/dev/null 2>&1
do
    sleep 1
done

if ! warp-cli --accept-tos account >/dev/null 2>&1
then
    warp-cli --accept-tos registration delete || true
    warp-cli --accept-tos registration new
fi

warp-cli --accept-tos mode warp
warp-cli --accept-tos connect

while true
do
    warp-cli --accept-tos status || true
    sleep 300
done
