#!/bin/bash
set -e

# Update packages (force IPv4 to avoid issues)
sudo apt-get -o Acquire::ForceIPv4=true update
sudo apt-get -o Acquire::ForceIPv4=true upgrade -y
sudo apt-get install -y curl build-essential

# Install Node.js 18 (includes npm)
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Go to project directory
cd /vagrant/ui || exit

# Install dependencies and start app if package.json exists
if [ -f package.json ]; then
  npm install
  # Kill any existing Node.js processes to avoid conflicts
  pkill -f "node" || true
  # Start app in background and log output
  nohup npm run start > ui.log 2>&1 &
else
  echo "No package.json found in /vagrant/ui"
fi
