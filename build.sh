#!/bin/sh

if [ $# -ne 3 ]; then
  echo "Usage: $0 arch subarch relver"
  echo "Example: $0 sunxi cortexa8 21.02.0-rc4"
  exit 1
fi

arch="$1"
subarch="$2"
relver="$3"

docker build -t zoobab/openwrtsdk:${relver}-${arch}-${subarch} --build-arg arch=$arch --build-arg subarch=$subarch --build-arg relver=$relver .
