sudo touch /home/coder/startup
cd /root
git clone https://github.com/AnEntrypoint/hyperbolic-tunnel
cd /root/hyperbolic-tunnel
git pull
npm install
sudo pm2 start --name gate runnode.js
cd /root
if [ ! -f /root/firstrundone ]
    then echo first run
    sudo touch /root/firstrundone
    head -n -1 /etc/passwd > /tmp/passwd
    sudo mv /tmp/passwd /etc/passwd
fi
cd /home/coder
sh /home/coder/startup 1>startup.log 2>startup.err &
sudo wget -r https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh -O /root/entrypoint.sh
sudo chmod a+x /root/entrypoint.sh
