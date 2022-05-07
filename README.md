# hyperbolic-code-server

get a live, online development environment immediately on your vps or host

```
x64
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh) email secretkeyforhyperaddress optionalpassword -x64
armv8
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh) email secretkeys password timezone 
```

you will see a log after the container is started which will include your matic.ml url and password

## can I connect to the machine without the matic.ml relay?

yes you can, right now its done using hyperbolic-client

https://github.com/lanmower/hyperbolic-client
