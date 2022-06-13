#!/bin/bash

if docker restart code-server; 
  then 
    hyperbolic_extern_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}');
    echo "enjoy hyperbolic-grain code-server on your local network at: http://$hyperbolic_extern_ip:8080";
    echo "bind_addr: 0.0.0.0"
    echo "on this device: http://localhost:8080 aka http://127.0.0.1:8080"; echo "";
    echo "to update grain: pull, build, install:"; echo "";
    echo "./pull-grain.sh";
    echo "./build.sh";
    echo "./remove.sh";
    echo "./install.sh"; echo "";
    # tail the logs
    docker logs code-server -f;
  else
    echo ""
    echo "you need to run install.sh to create the container.";
fi
