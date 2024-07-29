#!/bin/sh
# Create startup file
touch /home/coder/startup

# Set ownership of the hyperbolic-tunnel directory
chown coder:coder /home/coder/hyperbolic-tunnel/ || true

# Navigate to the project directory
cd /home/coder || exit
mkdir -p hyperbolic-tunnel
cd hyperbolic-tunnel || exit

# Pull the latest changes and install dependencies
git pull || echo "No repository found"
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
