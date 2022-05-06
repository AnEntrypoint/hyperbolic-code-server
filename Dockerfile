FROM codercom/code-server:latest
USER root
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata libcap2-bin
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y yarn
WORKDIR /home/coder
RUN npm install -g pm2
RUN echo 3
RUN git clone https://github.com/AnEntrypoint/hyperbolic-tunnel
WORKDIR /home/coder/hyperbolic-tunnel
RUN npm install
ENV target http://localhost:8080
RUN sudo chmod a+rw ~/ -R
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
RUN echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd
#USER coder
ENTRYPOINT sudo chmod a+rw /home/coder/.config -R; sudo target=$target http=$http https=$https node runnode.js $password $email & sleep 3 &&  sudo cat ~/.config/code-server/config.yaml & cd /home/coder; if [ ! -f firstrundone ]; then sudo touch firstrundone ; sudo head -n -1 /etc/passwd > /tmp/passwd ; sudo mv /tmp/passwd /etc/passwd ; fi ; /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
