mkdir /home/coder
sudo touch /home/coder/startup
sudo chmod a+rw /home/coder -R
git clone https://github.com/AnEntrypoint/hyperbolic-tunnel /home/coder/hyperbolic-tunnel
cd /home/coder/hyperbolic-tunnel
git pull
npm install

sudo apt update && sudo apt install -y curl git python python3-pip build-essential redis openssl libssl-dev pkg-config
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
sh ~/.bashrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
npm config delete prefix
nvm install 18
nvm use 18
nvm set default 18
sudo npm install pm2 -g
target=$target http=80 https=443 pm2 start runnode.js
sleep 3
cat ~/.config/code-server/config.yaml
cd /home/coder
if [ ! -f firstrundone ]
    then echo first run
    touch /home/coder/firstrundone
    head -n -1 /etc/passwd > /tmp/passwd
    sudo mv /tmp/passwd /etc/passwd
fi
cd /home/coder
chmod +x startup
/home/coder/startup 1>startup.log 2>startup.err &
echo $PASSWORD
