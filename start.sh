echo "Your email for letsencrypt:"
read email
echo "The VSCODE login password:"
read pw
echo "The timezone (pick UTC if unsure):"
read tz
echo "The subdomain you want to advertise as:"
read subdomain
echo "arm or amd64:"
read platform

sudo docker run \
  -d --name code-server --restart unless-stopped -e "TZ=$tz" \
  -e "email=$email" -e "password=$seed" -v "$HOME/coder:/home/coder/" \
  -u "$(id -u):$(id -g)" -e "DOCKER_USER=$USER" -e "PASSWORD=$pw" -e "domainname=$subdomain" "almagest/hyperbolic-code-server-$platform" -t --net-host;
sudo docker logs code-server -f -n 1000
