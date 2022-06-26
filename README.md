# hyperbolic-code-server

get a live, online development environment immediately on your vps or host

There are five parameters
 - your email (required for letsencrypt)
 - a password for vscode (if left out it will generate one)
 - a timezone (or just say UTC)
 - a unique subdomain name you can use instead of your base32 hash (single word no dots)
 - a selection of amd64 or arm
```
curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh | sudo bash
```

you will see a log after the container is started which will include your sites.247420.xyz url and password

you can check in on your server with

``` 
docker logs code-server -f
```

it should survive system restarts

if you're setting up a fresh vps, here's a blurb for opening the firewall, installing docker and adding an 8gb pagefile, this should prep most servers for this app on a fresh install:

```
curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/newhost.sh | sudo bash
```
(if docker is not available after run, try it again)
