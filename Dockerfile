# Dockerfile
FROM codercom/code-server:latest

USER root
RUN apt-get update && apt-get install -y ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update -y && apt-get install -y nodejs python3 build-essential tzdata libcap2-bin wget
RUN npm install -g pm2
ENV target http://localhost:8080
RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node
RUN cd /root
RUN git clone https://github.com/AnEntrypoint/hyperbolic-tunnel
