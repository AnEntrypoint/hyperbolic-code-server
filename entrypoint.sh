cd /root
git clone https://github.com/AnEntrypoint/hyperbolic-tunnel
cd /root/hyperbolic-tunnel
git pull
npm install
cd /root
if [ ! -f /root/firstrundone ]
    then echo first run
    sudo touch /root/firstrundone
    head -n -1 /etc/passwd > /tmp/passwd
    sudo mv /tmp/passwd /etc/passwd
fi
touch /home/coder/startup
pm2 start --name gate runnode.js
cd /home/coder
sh /home/coder/startup 1>startup.log 2>startup.err &
wget -r https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh -O /root/entrypoint.sh
chmod a+x /root/entrypoint.sh
