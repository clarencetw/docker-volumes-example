#!/bin/sh
set -e

echo "[Entrypoint] HTML Download"

curl https://file-examples-com.github.io/uploads/2017/02/index.html --output /data/html/index.html --create-dirs 