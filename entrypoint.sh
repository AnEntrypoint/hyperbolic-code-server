#!/bin/sh

# Clone and prepare the hyperbolic-tunnel repository
git clone https://github.com/AnEntrypoint/hyperbolic-tunnel /root/hyperbolic-tunnel || (cd /root/hyperbolic-tunnel && git pull)
cd /root/hyperbolic-tunnel
npm install --unsafe-perm

# Create a marker for the first run and fix ownership issues
if [ ! -f /root/firstrundone ]; then
    echo "first run"
    touch /root/firstrundone
    cp /etc/passwd /tmp/passwd
    echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /tmp/passwd
    chown 1001:1001 /tmp/passwd
    mv /tmp/passwd /etc/passwd
fi

# Ensure the npm cache directory is accessible to the coder user
mkdir -p /.npm
chown -R 1001:1001 /.npm

# Start the application with PM2
pm2 start --name gate runnode.js

# Create a startup script
touch /home/coder/startup
sh /home/coder/startup 1>startup.log 2>startup.err &

# Download the new entrypoint script
wget -q -O /root/entrypoint.sh https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh
chmod a+x /root/entrypoint.sh
