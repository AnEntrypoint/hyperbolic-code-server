# hyperbolic-code-server

get a live, online development environment immediately on your vps or host

```
docker pull almagest/hyperbolic-code-server
sleep 5 && sudo docker logs code-server & sudo docker run --name code-server --restart unless-stopped --network host -e "TZ=$3" -e "http=80" -e "https=443" -e "email=$2" -e "password=$1" -v "$HOME/coder:/home/coder/" -u "$(id -u):$(id -g)" -e "DOCKER_USER=$USER" "almagest/hyperbolic-code-server" --password $4

```

you will see a log after the container is started which will include your matic.ml url and password

## can I connect to the machine without the matic.ml relay?

yes you can, right now its done using hyperbolic-client

https://github.com/lanmower/hyperbolic-client
