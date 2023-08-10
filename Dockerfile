FROM codercom/code-server:latest
USER root
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata libcap2-bin
RUN npm install -g pm2
ENV target http://localhost:8080
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
RUN echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd
WORKDIR /home/coder
#USER coder
ENTRYPOINT sudo touch /home/coder/startup; \
    sudo chmod a+rw /home/coder -R; \
    git clone https://github.com/AnEntrypoint/hyperbolic-tunnel /home/coder/hyperbolic-tunnel || true; \
    cd /home/coder/hyperbolic-tunnel; \
    git pull; \
    npm install; \
    target=$target http=80 https=443 pm2 start runnode.js & \
    sleep 3 && \
    cat ~/.config/code-server/config.yaml & cd /home/coder; \
    if [ ! -f firstrundone ]; \
        then echo first run; \
        touch /home/coder/firstrundone ; \
        head -n -1 /etc/passwd > /tmp/passwd ; \
        sudo mv /tmp/passwd /etc/passwd ; \
    fi ; \
    cd /home/coder; \
    apt install nohup -y; \
    nohup /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 . 1>vscode.log 2>vscode.err & \
    sh /home/coder/startup; \
