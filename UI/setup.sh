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
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs

# -------------------------
# 4. Install Node dependencies
# -------------------------
cd "$APP_DIR"
npm install express

# -------------------------
# 5. Instructions to start server
# -------------------------
echo "✅ Frontend setup complete!"
echo "Run the following to start your UI server:"
echo "cd $APP_DIR && sudo node server.js"
echo "Make sure your EC2 security group allows inbound traffic on port 80."
