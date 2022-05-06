FROM codercom/code-server:latest
USER root
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y yarn
WORKDIR /home/coder
RUN npm install -g pm2
RUN echo 2
RUN git clone https://github.com/AnEntrypoint/hyperbolic-tunnel
WORKDIR /home/coder/hyperbolic-tunnel
RUN npm install
ENV target http://localhost:8080
RUN chmod a+rw /home/coder -R
#RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
RUN echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd
#USER coder
ENTRYPOINT  sudo chmod a+rw /home/coder -R; sudo target=$target http=$http https=$https node runnode.js $password $email & sleep 3 && cat /.config/code-server/config.yaml & cd /home/coder && sudo -u coder /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
