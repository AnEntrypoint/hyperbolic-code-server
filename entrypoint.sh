#!/bin/sh

# Create startup file and set ownership
sudo touch /home/coder/startup
sudo chown ubuntu:ubuntu /home/coder/hyperbolic-tunnel/* -R

# Navigate to the project directory
cd /home/coder
mkdir -p hyperbolic-tunnel
cd hyperbolic-tunnel

# Pull the latest changes and install dependencies
git pull
npm install

# Set environment and start the application with PM2
target=$target http=80 https=443 sudo pm2 start --name gate npx -- hyperbolic-tunnel

# Wait for the application to start
sleep 3

# Check the code-server configuration
cat ~/.config/code-server/config.yaml

# Create a marker for the first run
cd /home/coder
if [ ! -f firstrundone ]; then 
    echo "first run"
    touch /home/coder/firstrundone
   
    # Edit /etc/passwd to handle duplicates
    cp /etc/passwd /tmp/passwd
    awk '!seen[$0]++' /tmp/passwd > /etc/passwd  # Remove duplicate entries
    rm /tmp/passwd
fi

# Run the startup script in the background
sh /home/coder/startup 1>startup.log 2>startup.err &

# Print password and download the entrypoint script
echo $PASSWORD
