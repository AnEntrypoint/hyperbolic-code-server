deftimezone=Etc/GMT
sleep 5 && sudo docker logs code-server & sudo docker run \
  -d --name code-server --restart unless-stopped --network host -e "TZ=${$3:-$deftimezone}" \
  -e "http=80" -e "https=443" -e "email=$1" -e "password=$2" -v "$HOME/coder:/home/coder/" \
  -u "$(id -u):$(id -g)" -e "DOCKER_USER=$USER" "almagest/hyperbolic-code-server" --password $2
