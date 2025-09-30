#!/usr/bin/env bash
set -e

# 1. Update packages and install Docker + Git
sudo yum update -y
sudo yum install -y git docker

# 2. Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# 3. Clone repo to get schema.sql
REPO_DIR="/home/ec2-user/pokemon-app"
if [ ! -d "$REPO_DIR" ]; then
  git clone https://github.com/Finnamon1/AWSPokemonCardCollection.git "$REPO_DIR"
fi

# 4. MySQL environment variables
MYSQL_ROOT_PASSWORD="rootpassword"
MYSQL_USER="pokeuser"
MYSQL_PASSWORD="pokepass"
MYSQL_DATABASE="pokemon"  

# 5. Clean up old container if it exists
if [ "$(sudo docker ps -aq -f name=mysql-server)" ]; then
  sudo docker rm -f mysql-server
fi

# 6. Pull and run MySQL container with schema auto-loaded
sudo docker pull mysql:8.0
sudo docker run -d \
  --name mysql-server \
  -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -e MYSQL_USER="$MYSQL_USER" \
  -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  -p 3306:3306 \
  -v "$REPO_DIR/database":/docker-entrypoint-initdb.d:ro \
  mysql:8.0 --default-authentication-plugin=mysql_native_password --bind-address=0.0.0.0

echo "✅ MySQL Docker container started with database '$MYSQL_DATABASE' and schema applied."

sudo docker start mysql-server
echo "✅ MySQL Docker container is running."
