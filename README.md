# hyperbolic-code-server

get a live, online development environment immediately on your vps or host

```
sleep 5 && sudo docker logs code-server & sudo docker run \
  -d --name code-server --restart unless-stopped --network host -e "TZ=Etc/GMT" \
  -e "http=80" -e "https=443" -e "email=YOUREMAIL" -e "password=YOURPASSWORD" -v "$HOME/coder:/home/coder/" \
  -u "$(id -u):$(id -g)" -e "DOCKER_USER=$USER" "almagest/hyperbolic-code-server" --password YOURPASSWORD
```

you will see a log after the container is started which will include your matic.ml url and password

## can I connect to the machine without the matic.ml relay?

yes you can, right now its done using hyperbolic-client

https://github.com/lanmower/hyperbolic-client
