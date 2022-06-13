#!/bin/sh

# todo: check extension host started first. sleeping 30 seconds seems to work fine though!
sleep 30 && echo "installing extension: /home/coder/vscode-grain.vsix" && /usr/bin/code-server --install-extension /home/coder/vscode-grain.vsix
