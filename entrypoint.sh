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

# Function to fix duplicate entries in /etc/passwd
fix_duplicates() {
    local tmp_passwd="/tmp/passwd"
    cp /etc/passwd "$tmp_passwd"

    # Create an associative array
    declare -A user_dict

    # Read through passwd and remove duplicates
    {
        while IFS=: read -r user rest; do
            if [[ -n "${user}" && -n "${user_dict[$user]+xxx}" ]]; then
                echo "Duplicate found: $user"  # Optionally log or handle duplicates
            else
                user_dict["$user"]=1
                echo "$user:$rest" >> "$tmp_passwd"  # Include the rest of the fields
            fi
        done
    } < "$tmp_passwd"

    mv "$tmp_passwd" /etc/passwd
}

# Fix potential issues in /etc/passwd
echo "Checking for duplicates in /etc/passwd."
fix_duplicates

# Run pwck to ensure no users are broken after the fix
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
    # Check if 'coder' entry exists before appending
    if ! grep -q "^coder:" /etc/passwd; then
        echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd
    fi
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
