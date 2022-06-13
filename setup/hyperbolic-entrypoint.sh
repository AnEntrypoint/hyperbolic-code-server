#!/usr/bin/env bash
set -e

# setup hyperbolic-code-server environment in mounted volume
/usr/local/bin/hyperbolic-code-server-setup.sh

# run extension install script in background so it can wait for 
# vscode extension host to be ready
/usr/local/bin/hyperbolic-vscode-extensions.sh &

# start code-server
# note: code-server is exec'd with dumb-init https://github.com/Yelp/dumb-init
/usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
