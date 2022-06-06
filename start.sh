#!/bin/bash

if docker restart code-server; 
  then 
    hyperbolic_extern_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}');
    echo "enjoy hyperbolic-code-server on your local network at: http://$hyperbolic_extern_ip:8080";
    echo "bind_addr: 0.0.0.0"
    echo "on this device: http://localhost:8080 aka http://127.0.0.1:8080"; echo "";
    echo "you may also want to delete ~/coder/hyperbolic-tunnel which is bind mounted into the container.";
    echo "deleting it will ensure the settings chosen when running install.sh are correctly applied.";
    echo "do this before running ./install.sh";
  else
    echo ""
    echo "you need to run install.sh to create the container.";
    echo "if you have previously run install.sh ..."; echo "";
    echo "you may also want to delete ~/coder/hyperbolic-tunnel which is bind mounted into the container.";
    echo "deleting it will ensure the settings chosen when running install.sh are correctly applied.";
fi
