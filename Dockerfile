FROM codercom/code-server:latest
USER root
RUN sudo apt-get update
RUN sudo apt-get install -y ca-certificates curl gnupg
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN NODE_MAJOR=20
run echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata libcap2-bin wget
RUN npm install -g pm2
ENV target http://localhost:8080
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
RUN echo "coder:x:1001:1001::/home/coder:/bin/bash" >> /etc/passwd
WORKDIR /home/coder
USER coder
ENTRYPOINT sudo rm /home/coder/entrypoint.sh; \
    sudo wget https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh -O /home/coder/entrypoint.sh; \
    cat /home/coder/entrypoint.sh; \
    sh /home/coder/entrypoint.sh; \
    /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
