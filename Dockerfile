FROM codercom/code-server:latest
USER root
RUN sudo apt-get update
RUN sudo apt-get install -y ca-certificates curl gnupg
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update -y
RUN apt-get install -y nodejs python3 build-essential tzdata libcap2-bin wget
RUN npm install -g pm2
ENV target http://localhost:8080
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
RUN echo "coder:x:1001:1001::/root:/bin/bash" >> /etc/passwd
WORKDIR /root
USER coder
ENTRYPOINT sudo wget -q -O /root/entrypoint.sh https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/entrypoint.sh \
    ls \
    sh /root/entrypoint.sh; \
    /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
