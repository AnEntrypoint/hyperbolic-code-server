#!/bin/sh
set -e

# Create startup file and set ownership of hyperbolic-tunnel directory
touch /home/coder/startup || echo "Failed to create startup file"
chown coder:coder /home/coder/hyperbolic-tunnel/ || true

# Navigate to the project directory
cd /home/coder || exit 1
mkdir -p hyperbolic-tunnel
cd hyperbolic-tunnel || exit 1

# Pull the latest changes and install dependencies
if [ -d .git ]; then
    git pull || echo "No repository found"
fi
npm install || echo "Failed to install dependencies"

# Set environment and start the application with PM2
target=$target http=80 https=443 pm2 start --name gate npx -- hyperbolic-tunnel

# Wait for the application to start
sleep 3

# Check the code-server configuration
mkdir -p ~/.config/code-server
cat ~/.config/code-server/config.yaml || echo "Config file not found"

# Create a marker for the first run
if [ ! -f /home/coder/firstrundone ]; then 
    echo "first run"
    touch /home/coder/firstrundone
fi

# Run the startup script in the background
sh /home/coder/startup 1>startup.log 2>startup.err &

# Print password
echo $PASSWORD
