# hyperbolic-code-server

get a live, online development environment immediately on your vps or host

There are four parameters
 - your email (required for lesencrypt)
 - your secre key for generating a hyper address (any text make it long/unique)
 - a password for vscode (if left out it will generate one)
 - a timezone if you dont want UTC

```
x64
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh) email secretkeyforhyperaddress password UTC -x64
armv8
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh) email secretkeys optionalpassword optionaltimezone
```

you will see a log after the container is started which will include your matic.ml url and password

## can I connect to the machine without the matic.ml relay?

yes you can, right now its done using hyperbolic-client

https://github.com/lanmower/hyperbolic-client
