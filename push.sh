#!/bin/bash

platform=""
case $(uname -m) in
x86_64) platform="amd64" ;;
aarch64) platform="arm64" ;;
arm) dpkg --print-architecture | grep -q "arm64" && platform="arm64" || platform="arm32" ;;
esac
if [[ (! $platform == "arm32" && ! $platform == "arm64" && ! $platform == "amd64") ]]; then
  echo "arm or amd64 is needed to pull the right docker image to run"
  exit 1
fi

docker_tag=av8ta/hyperbolic-grain:main-$platform

docker push $docker_tag
