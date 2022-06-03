#!/bin/bash

# exit when any command fails
set -e

echo "your email for letsencrypt:"
read email
regex="^[a-z0-9!#\$%&'*+/=?^_\`{|}~-]+(\.[a-z0-9!#$%&'*+/=?^_\`{|}~-]+)*@([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]([a-z0-9-]*[a-z0-9])?\$"
checkemail() {
        if [[ ! ($email =~ $regex) ]] ;
                then echo "letsencrypt needs a valid email address"; exit 1;
        fi
}
checkemail;

echo "the hyper seed to generate a key from: (long and unique)"
read seed

echo "vscode login password:"
read pw

echo "timezone: "
read tz
if [[ $tz        == "" ]]; then tz=UTC ; echo "timezone is UTC"; fi

echo "subdomain you want to advertise as: (<subdomain>.sites.247420.xyz)"
read subdomain

# platform=""
# case $(uname -m) in
#     x86_64) platform="amd64" ;;
#     arm)    dpkg --print-platform | grep -q "arm64" && platform="arm64" || platform="arm" ;;
# esac
# if [[ (! $platform  == "arm" && ! $platform == "amd64") ]]; then echo "arm or amd64 is needed to pull the right docker image to run"; exit 1; fi

platform=""
case $(uname -m) in
    x86_64) platform="amd64" ;;
    aarch64) platform="arm64" ;;
    arm)    dpkg --print-architecture | grep -q "arm64" && platform="arm64" || platform="arm32" ;;
esac
echo $platform
if [[ (! $platform  == "arm32" && ! $platform  == "arm64" && ! $platform == "amd64") ]]; then echo "arm or amd64 is needed to pull the right docker image to run"; exit 1; fi
echo "platform is $platform. starting hyperbolic-grain now..."; echo "";

if [[ $email     == "" ]]; then echo "email is needed for letsencrypt certificates"; exit 1; fi
if [[ $seed      == "" ]]; then echo "hyper seed is needed to generate a unique hypercore-protocol address."; echo "anything long and unique will do."; echo "you don't need to save it for later :)"; exit 1; fi
if [[ $pw        == "" ]]; then echo "password is needed for vscode as it will be accessible online"; exit 1; fi
if [[ $subdomain == "" ]]; then echo "please set a subdomain to advertise on"; exit 1; fi

docker run \
  -d --name code-server --restart unless-stopped --network host -e "TZ=$tz" \
  -e "email=$email" -e "password=$seed" -v "$HOME/coder:/home/coder/" \
  -u "$(id -u):$(id -g)" -e "DOCKER_USER=$USER" -e "PASSWORD=$pw" -e "domainname=$subdomain" "av8ta/hyperbolic-grain:main-$platform";
docker logs code-server -f
