#!/bin/sh

sudo touch /home/coder/startup
# set permissions for grain and home \
sudo chmod a+rw /grain -R
sudo chmod a+rw /home/coder -R
# alias 'code' so you can open files from terminal
touch /home/coder/.bashrc; if ! cat /home/coder/.bashrc | grep -q 'alias code="'; then echo 'alias code="/usr/lib/code-server/bin/code-server"' >> /home/coder/.bashrc; fi 
# make an accessible global node_modules for userland installs
if ! cat /home/coder/.bashrc | grep -q 'export PATH=/home/coder/.global_node_modules/bin:'; then echo "export PATH=/home/coder/.global_node_modules/bin:$PATH" >> /home/coder/.bashrc; fi
mkdir /home/coder/.global_node_modules
npm config set prefix "/home/coder/.global_node_modules"
# decrease ssh private key permissions
if ls /home/coder/.ssh | grep "id_rsa"; then chmod 600 /home/coder/.ssh/id_rsa*; fi;
# maybe download vscode-grain extension
# save compatible grain vscode extension (compatible with older vscode 1.66.2)
vscode_grain_ext=/home/coder/vscode-grain.vsix
if [ -f "$vscode_grain_ext" ];
  then  echo "vscode grain extension found";
  else  echo "vscode grain extension not found";
        echo "Install grain language vscode extension vscode-grain.vsix in this directory\n" > /home/coder/readme-vscode-grain-extension.md;
        echo "https://coder.com/docs/code-server/latest/FAQ#how-do-i-install-an-extension\n" >> /home/coder/readme-vscode-grain-extension.md;
        echo "Or alternatively, install via the gui extension manager in the left sidebar." >> /home/coder/readme-vscode-grain-extension.md;
        curl --output /home/coder/vscode-grain.vsix https://raw.githubusercontent.com/av8ta/grain-language-server/master/editor-extensions/vscode/vscode-grain-0.16.0.vsix;
fi;
# setup hyperbolic tunnel over hyperswarm \ 
git clone https://github.com/AnEntrypoint/hyperbolic-tunnel /home/coder/hyperbolic-tunnel || true
cd /home/coder/hyperbolic-tunnel
npm install
target=$target http=80 https=443 node runnode.js $password $email & \
sleep 3 && \
cat ~/.config/code-server/config.yaml & cd /home/coder
if ! cat /etc/passwd | grep -q "coder:"; then echo "adding coder user"; echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd; fi;
