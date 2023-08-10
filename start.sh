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
  -u "$(id -u):$(id -g)" -e "DOCKER_USER=$USER" -e "PASSWORD=$pw" -e "domainname=$subdomain" -p 3000-4000:3000-4000 -p 80:80 -p 443:443 -p 8080:8080 "almagest/hyperbolic-code-server-$platform";
sudo docker logs code-server -f -t
