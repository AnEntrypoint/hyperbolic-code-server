#!/bin/sh

vscode_grain_ext=/home/coder/vscode-grain.vsix
if [ -f "$vscode_grain_ext" ];
  then  echo "vscode grain extension found";
  else  echo "vscode grain extension not found, downloading...";
        curl --output /home/coder/vscode-grain.vsix https://raw.githubusercontent.com/av8ta/grain-language-server/master/editor-extensions/vscode/vscode-grain-0.16.0.vsix;
fi;

# todo: check extension host started first. sleeping 30 seconds seems to work fine though!
sleep 30 && echo "installing extension: /home/coder/vscode-grain.vsix" && /usr/bin/code-server --install-extension /home/coder/vscode-grain.vsix
