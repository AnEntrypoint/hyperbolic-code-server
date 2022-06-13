FROM codercom/code-server:latest as code-server
USER root
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get update -y && \
    apt-get install -y nodejs yarn wget python3 build-essential tzdata libcap2-bin

# now that node is installed; copy and install grain from dockerhub
COPY --from=grainlang/grain:main-slim /grain /grain
WORKDIR /grain
# Link grain cli
RUN npm run cli link

ENV target http://localhost:8080
RUN sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/node

# entrypoint setup scripts
COPY ./setup.sh /usr/local/bin/hyperbolic-grain-setup.sh
RUN ["chmod", "+x", "/usr/local/bin/hyperbolic-grain-setup.sh"]

COPY ./install-grain-extension.sh /usr/local/bin/install-grain-extension.sh
RUN ["chmod", "+x", "/usr/local/bin/install-grain-extension.sh"]

COPY ./entrypoint.sh /usr/local/bin/hyperbolic-grain-entrypoint.sh
RUN ["chmod", "+x", "/usr/local/bin/hyperbolic-grain-entrypoint.sh"]

USER coder
WORKDIR /home/coder

ENTRYPOINT ["/usr/local/bin/hyperbolic-grain-entrypoint.sh"]
