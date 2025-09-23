#!/usr/bin/env bash
set -e



# 1. Update & install dependencies
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1
sudo sed -i 's|http://archive.ubuntu.com/ubuntu|http://nz.archive.ubuntu.com/ubuntu|g' /etc/apt/sources.list
sudo apt-get -o Acquire::ForceIPv4=true update #weird IPv4 & 6 stuff above was because kept getting netowrk errors that only went away when doing this for API so am keeping it.
sudo apt-get -o Acquire::ForceIPv4=true upgrade -y
sudo apt-get install -y curl build-essential




# 2. Install Node.js 18 & npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
sudo apt-get install -y nodejs

# 3. Install pm2 globally
sudo npm install -g pm2

# 4. Install API dependencies
cd /vagrant/API
sudo npm install --no-bin-links express mysql2 cors

# 5. Start API with pm2
sudo -u vagrant pm2 start /vagrant/API/index.js --name "pokemon-api"
sudo -u vagrant pm2 save

# 6. Configure pm2 to start on VM boot

sudo pm2 startup systemd -u vagrant --hp /home/vagrant
