FROM codercom/code-server:latest
USER root
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata libcap2-bin
WORKDIR /
RUN npm install -g pm2
RUN git clone https://github.com/AnEntrypoint/hyperbolic-tunnel
WORKDIR /hyperbolic-tunnel
RUN npm install
ENV target http://localhost:8080
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
RUN echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd
#USER coder
ENTRYPOINT sudo chmod a+rw /home/coder -R; \
    sudo chmod a+rw /hyperbolic-tunnel -R; \
    target=$target http=80 https=443 node runnode.js $password $email & \
    sleep 3 && \
    cat ~/.config/code-server/config.yaml & cd /home/coder; \
    if [ ! -f firstrundone ]; \
        then echo first run; \
        touch /home/coder/firstrundone ; \
        head -n -1 /etc/passwd > /tmp/passwd ; \
        sudo mv /tmp/passwd /etc/passwd ; \
    fi ; \
    cd /home/coder && /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
