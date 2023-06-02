#!/bin/bash

# exit when any command fails
set -e

# load env vars if any
ENV_FILE=./env.sh
if [[ -f "$ENV_FILE" ]]; then source ./env.sh || true; \
echo "seed: $seed"; \
echo "subdomain: $subdomain"; \
echo "email: $email"; \
echo ""; fi;

echo "vscode login password:"; read pw;
if [[ ${#pw} -lt 8 ]]; then echo "password ought to be at least characters long. it's only ${#pw}"; exit 1; fi;

if [[ $email == "" ]]; then echo "your email for letsencrypt:"; read email; fi;
regex="^[a-z0-9!#\$%&'*+/=?^_\`{|}~-]+(\.[a-z0-9!#$%&'*+/=?^_\`{|}~-]+)*@([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]([a-z0-9-]*[a-z0-9])?\$"
checkemail() {
  if [[ ! ($email =~ $regex) ]] ;
    then echo "letsencrypt needs a valid email address"; exit 1;
  fi
}
checkemail;

if [[ $seed == "" ]]; then echo "the hyper seed to generate a key from: (long and unique)"; read seed; fi;
if [[ $tz == "" ]]; then echo "timezone: (enter for UTC)"; read tz; fi;
if [[ $tz        == "" ]]; then tz=UTC ; echo "timezone is set to UTC"; fi;
if [[ $subdomain == "" ]]; then echo "subdomain you want to advertise as: <subdomain>.sites.247420.xyz"; read subdomain; fi;

platform=""
case $(uname -m) in
    x86_64) platform="amd64" ;;
    aarch64) platform="arm64" ;;
    arm)    dpkg --print-architecture | grep -q "arm64" && platform="arm64" || platform="arm32" ;;
esac
echo ""
echo $platform
if [[ (! $platform  == "arm32" && ! $platform  == "arm64" && ! $platform == "amd64") ]]; then echo "arm or amd64 is needed to pull the right docker image to run"; exit 1; fi
echo "platform is $platform. starting hyperbolic-code-server now..."; echo "";

if [[ $email     == "" ]]; then echo "email is needed for letsencrypt certificates"; exit 1; fi
if [[ $seed      == "" ]]; then echo "hyper seed is needed to generate a unique hypercore-protocol address."; echo "anything long and unique will do."; echo "you don't need to save it for later :)"; exit 1; fi
if [[ $pw        == "" ]]; then echo "password is needed for vscode as it will be accessible online"; exit 1; fi
if [[ $subdomain == "" ]]; then echo "please set a subdomain to advertise on"; exit 1; fi

echo "#!/bin/bash" > env.sh
chmod +x ./env.sh
echo "" >> env.sh
echo "export email=$email" >> env.sh
echo "export seed=$seed" >> env.sh
echo "export subdomain=$subdomain" >> env.sh
echo "export tz=$tz" >> env.sh

hyperbolic_extern_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
echo "enjoy hyperbolic code-server on your local network at: http://$hyperbolic_extern_ip:8080"

docker_tag=almagest/hyperbolic-code-server-$platform
echo "installing $docker_tag"

docker run \
  -d --name code-server --restart unless-stopped -e "TZ=$tz" \
  -e "email=$email" -e "password=$seed" -v "$HOME/coder:/home/coder/" \
  -u "$(id -u):$(id -g)" -e "DOCKER_USER=$USER" -e "PASSWORD=$pw" -e "domainname=$subdomain" \
  -p 3000-4000:3000-4000 -p 80:80 -p 443:443 \
  $docker_tag;
docker logs code-server -f;
