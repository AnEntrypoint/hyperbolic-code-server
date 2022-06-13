#!/usr/bin/env bash
set -e

# setup hyperbolic-grain environment in mounted volume
/usr/local/bin/hyperbolic-grain-setup.sh

# run extension install script in background waiting for code-server to be ready
/usr/local/bin/install-grain-extension.sh &

# start code-server
# note: code-server is exec'd with dumb-init https://github.com/Yelp/dumb-init
/usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
