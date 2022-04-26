# hyperbolic-code-server

Instructions so far

```
sudo apt update
sudo apt install docker.io

curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | sh
sudo curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | sh
sudo chmod +x ~/.profile
chmod +x ~/.profile

source ~/.profile
nvm install 14
sudo npm install pm2 -g

git clone https://github.com/AnEntrypoint/hyperbolic-code-server.git
cd hyperbolic-code-server/
npm install
node init.js
cd tunnel


sudo docker run -it --name code-server -p 127.0.0.1:8080:8080 \
  -v "$HOME/.config:/home/coder/.config" \
  -v "$PWD:/home/coder/project" \
  -u "$(id -u):$(id -g)" \
  -e "DOCKER_USER=$USER" \
  codercom/code-server:latest

sudo fallocate -l 4G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sh -c "echo '/swapfile swap swap defaults 0 0' >> /etc/fstab"
```
