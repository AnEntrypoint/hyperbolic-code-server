FROM codercom/code-server:latest
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata libcap2-bin
RUN npm install -g pm2
ENV target http://localhost:8080
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
WORKDIR /home/coder
ENTRYPOINT sudo chmod a+rw /home/coder -R; \
    git clone https://github.com/AnEntrypoint/hyperbolic-tunnel /home/coder/hyperbolic-tunnel || true; \
    cd /home/coder/hyperbolic-tunnel; \
    npm install; \
    target=$target http=80 https=443 node runnode.js $password $email & \
    sleep 3 && \
    cat ~/.config/code-server/config.yaml & cd /home/coder; \
    cd /home/coder && /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
