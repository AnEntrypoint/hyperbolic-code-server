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
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh) email secretkeys optionalpassword UTC -arm
```

you will see a log after the container is started which will include your matic.ml url and password

you can check in on your server with

``` 
sudo docker logs code-server -f
```

it should survive system restarts

if you're setting up a fresh vps, here's a blurb for opening the firewall, installing docker and adding an 8gb pagefile, this should prep most servers for this app on a fresh install:

```

```

## can I connect to the machine without the matic.ml relay?

yes you can, right now its done using hyperbolic-client

https://github.com/lanmower/hyperbolic-client

### direct connection

if you go look in the hyperbolic-tunnel files that get created under ~/coder, you'll see the config for greenlock under the site directory, you can add additional urls of your sites custom domain in there under sites (the file is config.json), and then open your code-server without the hyperswarm relay, and you should also be able to reach it on port 8080 without ssl, once you modify the config under ~/coder/.config/code-server/config.yaml, where you can change the host from 127.0.0.1 to 0.0.0.0

### can I make more tunnels?

yes you can, right now the easiest way to do it is to just git clone out more hyperbolic-tunnel instances, and run them in their own path, they'll set themselves up on other ports

### can I vhost additional applications on my server

yes that's done in the site configs
hyperbolic-tunnel/site/routerconfig.json should gain an additional site
hyperbolictunnel/site/config.json should route that hostname to an additional address
```

```
