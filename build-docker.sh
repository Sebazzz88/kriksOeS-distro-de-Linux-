#!/bin/bash
# Construye la ISO en un contenedor Debian 13. La ISO queda en ./out/
set -euo pipefail
cd "$(dirname "$0")"
docker run --rm --privileged -v "$PWD":/build -w /build debian:trixie bash ./build.sh
