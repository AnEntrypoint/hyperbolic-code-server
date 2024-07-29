#!/bin/bash

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update -y 
sudo apt-get install -y nodejs python3 build-essential tzdata libcap2-bin wget
ENV target http://localhost:8080
setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node

git clone https://github.com/AnEntrypoint/hyperbolic-tunnel

npm install pm2 -g
sudo npm install pm2 -g

sudo apt update
cd ~/
sudo sh watchers
sudo apt install python3-pip -y
sudo apt install ffmpeg -y
sudo pip install youtube-dl
sudo apt install nohup

cd ~/hyperbolic-tunnel
npm install
sudo pm2 start runnode.js --name gate

sudo apt install -y curl git python python3-pip build-essential redis openssl libssl-dev pkg-config
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

sh ~/.bashrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
npm config delete prefix
nvm install 18
nvm use 18
nvm set default 18

sudo export NVM_DIR="$HOME/.nvm"
sudo [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
sudo [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
sudo npm config delete prefix
sudo nvm install 18
sudo nvm use 18
sudo nvm set default 18

sudo apt-get install nginx -y
sudo apt install libnginx-mod-rtmp -y
sudo rm /etc/nginx/nginx.conf
sudo ln -s /home/coder/nginx.conf /etc/nginx/nginx.conf
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /home/coder/rtmp /etc/nginx/sites-enabled/rtmp
sudo rm -r /var/www/html
sudo ln -s /home/coder/html /var/www/html
sudo service nginx restart
sudo apt install python3-pip -y
sudo apt install ffmpeg -y
