sleep 5 && sudo docker logs code-server & sudo docker run -d --name code-server --restart unless-stopped --network host -e "TZ=$3" -e "email=$2" -e "password=$1"  -v "$HOME/.config:/home/coder/.config"   -v "$PWD:/home/coder/project"   -u "$(id -u):$(id -g)"   -e "DOCKER_USER=$USER" "hyperbolic-code-server"
