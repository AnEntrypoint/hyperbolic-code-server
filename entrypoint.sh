sudo touch /home/coder/startup
sudo chown coder:coder /home/coder -R
git clone https://github.com/AnEntrypoint/hyperbolic-tunnel /home/coder/hyperbolic-tunnel
rm /home/coder/entrypoint.sh
cd /home/coder
wget https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh
sudo chmod a+x /home/coder/entrypoint.sh
sudo chmod a+x /home/coder/startup
cd /home/coder/hyperbolic-tunnel
git pull
npm install
sudo target=$target http=80 https=443 pm2 start runnode.js
sleep 3
cat ~/.config/code-server/config.yaml
cd /home/coder
if [ ! -f firstrundone ]
    then echo first run
    touch /home/coder/firstrundone
    head -n -1 /etc/passwd > /tmp/passwd
    sudo mv /tmp/passwd /etc/passwd
    sudo chmod +x startup
fi
cd /home/coder

/home/coder/startup 1>startup.log 2>startup.err &
echo $PASSWORD
