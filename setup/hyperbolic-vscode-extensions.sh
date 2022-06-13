#!/bin/bash

# $1: filepath $2: url (often https://raw.githubusercontent.com/...)
install_extension() {
  vscode_ext="$1"
  if [ -f "$vscode_ext" ]; then
    echo "vscode extension $1 found, skipping download and install"
  else
    echo "vscode extension $1 not found, downloading from $2..."
    curl --output /home/coder/"$1" "$2"
    echo "installing extension: $1"
    /usr/bin/code-server --install-extension /home/coder/"$1"
  fi
}

sleep 1 && attempt=0
max_attempts=50
while true; do
  if ((attempt == max_attempts)); then
    echo "max attempts: $max_attempts waiting for extension host to start. aborting vscode extension installs."
    echo "you can install them manually in vscode"
    break
  fi
  sleep 5
  log_file=/home/coder/dockerlogs/install.log
  if [[ ! -f "$log_file" ]] 2>/dev/null; then
    echo "no docker log tailed into volume"
    break
  fi
  if grep -q -i --no-messages "Extension host agent started." /home/coder/dockerlogs/install.log; then
    install_extension "vscode-grain.vsix" "https://raw.githubusercontent.com/av8ta/grain-language-server/master/editor-extensions/vscode/vscode-grain-0.16.0.vsix"
    break
  else
    echo "attempt number $((attempt++)) waiting for extension host to start"
  fi
done
