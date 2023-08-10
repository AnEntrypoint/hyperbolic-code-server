FROM codercom/code-server:latest
USER root
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata libcap2-bin wget
RUN npm install -g pm2
ENV target http://localhost:8080
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
RUN echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd
WORKDIR /home/coder
USER coder
ENTRYPOINT sudo wget https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh -O /home/coder/entrypoint.sh; \
    sudo rm /home/coder/entrypoint.sh; \
    ls /home/coder; \
    sudo sh /home/coder/entrypoint.sh; \
    /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
