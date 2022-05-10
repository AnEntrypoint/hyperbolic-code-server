sudo docker run \
  -d --name code-server --restart unless-stopped --network host -e "TZ=$4" \
  -e "email=$1" -e "password=$2" -v "$HOME/coder:/home/coder/" \
  -u "$(id -u):$(id -g)" -e "DOCKER_USER=$USER" -e "PASSWORD=$3" -e "domainname=$5" "almagest/hyperbolic-code-server$5";
sudo docker logs code-server -f
