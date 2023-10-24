sudo touch /home/coder/startup
sudo chown ubuntu:ubuntu /home/coder/hyperbolic-tunnel/* -R
cd /home/coder
mkdir hyperbolic-tunnel
cd /home/coder/hyperbolic-tunnel
git pull
npm install
target=$target http=80 https=443 sudo pm2 start --name gate npx -- hyperbolic-tunnel
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

sh /home/coder/startup 1>startup.log 2>startup.err &
echo $PASSWORD
sudo wget https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh -r
