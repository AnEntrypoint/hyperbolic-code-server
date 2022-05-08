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
bash <(curl -s https://raw.githubusercontent.com/AnEntrypoint/hyperbolic-code-server/main/start.sh) email secretkeys optionalpassword optionaltimezone UTC -arm
```

you will see a log after the container is started which will include your matic.ml url and password

you can check in on your server with

``` 
sudo docker logs code-server -f
```

it should survive system restarts

if you're setting up a fresh vps, here's a blurb for opening the firewall, installing docker and adding an 8gb pagefile, this should prep most servers for this app on a fresh install:

```
# INSTALL DOCKER

sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

sudo ufw disable
# Accept all traffic first to avoid ssh lockdown  via iptables firewall rules #
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
 
# Flush All Iptables Chains/Firewall rules #
sudo iptables -F
 
# Delete all Iptables Chains #
sudo iptables -X
 
# Flush all counters too #
sudo iptables -Z 
# Flush and delete all nat and  mangle #
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -t raw -F
sudo iptables -t raw -X

sudo iptables-save > /etc/iptables/rules.v4
sudo ip6tables-save > /etc/iptables/rules.v6

sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile swap swap defaults 0 0" | sudo tee /etc/fstab > /dev/null
```

## can I connect to the machine without the matic.ml relay?

yes you can, right now its done using hyperbolic-client

https://github.com/lanmower/hyperbolic-client

### direct connection

if you go look in the hyperbolic-tunnel files that get created under ~/coder, you'll see the config for greenlock under sites, you can add additional urls of your sites custom domain in there under sites, and then open your code-server without the hyperswarm relay, and you should also be able to reach it on port 8080 without ssl, once you modify the config under ~/coder/.config/code-server/config.yaml, where you can change the host from 127.0.0.1 to 0.0.0.0
