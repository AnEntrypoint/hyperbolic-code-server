#!/bin/sh

# Function to ensure commands have the right permissions
set_permissions() {
    local dir="$1"
    local user="$2"
    local group="$3"
    
    mkdir -p "$dir"
    chown -R "$user:$group" "$dir"
}

# Check if user can run necessary commands
if ! command -v pwck &> /dev/null; then
    echo "pwck could not be found. Please install it."
    exit 1
fi

# Fix potential issues in /etc/passwd
if ! pwck -r; then
    echo "Please fix duplicates in /etc/passwd."
    exit 1
fi

if ! pwck -r; then
    echo "Please fix duplicates in /etc/shadow."
    exit 1
fi

# Clone and prepare the hyperbolic-tunnel repository
if [ ! -d "/home/coder/hyperbolic-tunnel" ]; then
    git clone https://github.com/AnEntrypoint/hyperbolic-tunnel /home/coder/hyperbolic-tunnel
else
    (cd /home/coder/hyperbolic-tunnel && git pull)
fi

cd /home/coder/hyperbolic-tunnel || exit
npm install --unsafe-perm

# Create a marker for the first run
if [ ! -f /home/coder/firstrundone ]; then
    echo "first run"
    touch /home/coder/firstrundone
    cp /etc/passwd /tmp/passwd
    echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /tmp/passwd
    mv /tmp/passwd /etc/passwd
fi

# Fix permissions for npm and PM2 directories
set_permissions "/home/coder/.npm" "coder" "coder"
set_permissions "/home/coder/.pm2" "coder" "coder"

# Start the application with PM2
sudo -u coder pm2 start --name gate runnode.js

# Create a startup script
sudo -u coder touch /home/coder/startup
sudo -u coder sh /home/coder/startup 1>startup.log 2>startup.err &

# Download the new entrypoint script
wget -q -O /home/coder/entrypoint.sh https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh
sudo -u coder chmod a+x /home/coder/entrypoint.sh
