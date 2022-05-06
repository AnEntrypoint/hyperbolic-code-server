FROM codercom/code-server:latest
# Run everything as root
USER root
RUN echo 16
# Install whichever Node version is LTS
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs python3 build-essential tzdata

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y yarn
WORKDIR /home/coder
RUN git clone https://github.com/AnEntrypoint/hyperbolic-tunnel
WORKDIR /home/coder/hyperbolic-tunnel

RUN npm install -g pm2
RUN npm install
ENV target http://localhost:8080
RUN chmod a+w ./
USER coder
EXPOSE 443
EXPOSE 80
EXPOSE 3000
ENTRYPOINT node runnode.js & sleep 3 && cat /home/coder/.config/code-server/config.yaml & cd /home/coder; /usr/bin/entrypoint.sh --bind-addr 0.0.0.0:8080 .
