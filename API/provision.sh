#!/usr/bin/env bash
set -e

# 1. Update packages & install dependencies
sudo yum update -y
sudo yum install -y git

# 2. Clone repo
if [ ! -d /home/ec2-user/pokemon-app ]; then
  git clone https://github.com/Finnamon1/AWSPokemonCardCollection.git /home/ec2-user/pokemon-app
fi

# 3. Install Node.js 18 & npm
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs

# 4. Install pm2 globally
sudo npm install -g pm2

# 5. Install API dependencies
cd /home/ec2-user/pokemon-app/API
sudo npm install --no-bin-links express mysql2 cors

# 6. Start API with pm2
sudo -u ec2-user pm2 start index.js --name "pokemon-api"
sudo -u ec2-user pm2 save


