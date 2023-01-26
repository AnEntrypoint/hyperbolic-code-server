# hyperbolic-code-server

get a live, online development environment immediately on your vps or host

(tl;dr)
```
(install docker and set up swap file on vps)
curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/newhost.sh | sudo bash
(install this app)
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh)
```

There are five parameters
 - your email (required for letsencrypt)
 - a password for vscode (if left out it will generate one)
 - a timezone (or just say UTC)
 - a unique subdomain name you can use instead of your base32 hash (single word no dots)
 - a selection of amd64 or arm
```
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh)
```

you will see a log after the container is started which will include your 247420.xyz url and password

your code server will be on code.YOURNAME.247420.xyz

you can check in on your server with

``` 
docker logs code-server -f
```

it should survive system restarts

if you're setting up a fresh vps, here's a blurb for opening the firewall, installing docker and adding an 8gb pagefile, this should prep most servers for this app on a fresh install:

```
curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/newhost.sh | sudo bash
```

# How do I update my config?
you can edit hyperconfig.json to advertise more names
youc an edit routerconfig.json to add more incoming endpoints
after doing any updates, you will want to restart the reverse proxy (inside vscode terminal)...
```
pm2 restart runnode
```
if you want to update hyperbolic-tunnel to a newer version...
```
cd ~/hyperbolic-tunnel
git pull
pm2 restart runnode
```

# I'm stuck, my installation is somehow messed up, how do I recover my vscode?
You can reload everything without losing any data, here's what I do:
```
curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/remove.sh | sudo bash;

sudo docker system prune --all;

rm ~/coder/firstrundone;
rm ~/coder/hyperbolic-tunnel/run;
cd ~/coder/hyperbolic-tunnel;
rm -r package-lock.json;
rm -r node_modules;
git reset --hard;
git pull;
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh);
```

# I lost my login!

just do this
 
```
sudo docker exec -it code-server sh
```
 
then
 
```
echo $PASSWORD
```
