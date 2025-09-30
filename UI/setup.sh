#!/usr/bin/env bash
set -e

# -------------------------
# 1. Update packages & install dependencies
# -------------------------
sudo yum update -y
sudo yum install -y git curl

# -------------------------
# 2. Clone repo if it doesn't exist
# -------------------------
APP_DIR="/home/ec2-user/pokemon-app"
if [ ! -d "$APP_DIR" ]; then
  git clone https://github.com/Finnamon1/AWSPokemonCardCollection.git "$APP_DIR"
fi

# -------------------------
# 3. Install Node.js 18 & npm
# -------------------------
sudo yum install -y nodejs

# -------------------------
# 4. Install Node dependencies
# -------------------------
cd "$APP_DIR"
npm install express@4

# -------------------------
# 5. Instructions to start server
# -------------------------
echo "✅ Frontend setup complete!"

