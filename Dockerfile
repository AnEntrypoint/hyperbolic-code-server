FROM codercom/code-server:latest

USER root
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata libcap2-bin
RUN npm install -g pm2
ENV target http://localhost:8080
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node

WORKDIR /home/coder

USER coder
ENTRYPOINT touch /home/coder/.bashrc; \
    # alias 'code' so you can open files from terminal \
    if ! cat /home/coder/.bashrc | grep -q 'alias code="'; then echo 'alias code="/usr/lib/code-server/bin/code-server"' >> /home/coder/.bashrc; fi; \
    # make an accessible global node_modules for userland npm global installs \
    if ! cat /home/coder/.bashrc | grep -q 'export PATH=/home/coder/.global_node_modules/bin:'; then echo "export PATH=/home/coder/.global_node_modules/bin:$PATH" >> /home/coder/.bashrc; fi; \
    mkdir /home/coder/.global_node_modules; \
    npm config set prefix "/home/coder/.global_node_modules"; \
    # set permissions for home \
    sudo chmod a+rw /home/coder -R; \
    # decrease ssh private key permissions
    if ls /home/coder/.ssh | grep "id_rsa"; then chmod 600 /home/coder/.ssh/id_rsa*; fi; \
    # setup hyperbolic tunnel over hyperswarm \ 
    git clone https://github.com/AnEntrypoint/hyperbolic-tunnel /home/coder/hyperbolic-tunnel || true; \
    cd /home/coder/hyperbolic-tunnel; \
    npm install; \
    target=$target http=80 https=443 pm2 start runnode.js & \
    sleep 3 && \
    cat ~/.config/code-server/config.yaml & cd /home/coder; \
    if ! cat /etc/passwd | grep -q "coder:"; then echo "adding coder user"; echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd; fi; \
    cd /home/coder && /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
