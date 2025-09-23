# 1. Update packages
sudo yum update -y
sudo yum install -y git docker

# 2. Start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# 3. Clone repo to get schema.sql
REPO_DIR="/home/ec2-user/pokemon-app"
if [ ! -d "$REPO_DIR" ]; then
  git clone https://github.com/Finnamon1/AWSPokemonCardCollection.git "$REPO_DIR"
fi

# 4. Set MySQL environment variables
MYSQL_ROOT_PASSWORD="rootpassword"
MYSQL_USER="pokeuser"
MYSQL_PASSWORD="pokepass"
MYSQL_DATABASE="pokemon_db"

# 5. Pull and run MySQL Docker container
sudo docker pull mysql:8.0
sudo docker run -d \
  --name mysql-server \
  -e MYSQL_ROOT_PASSWORD="$MYSQL_ROOT_PASSWORD" \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -e MYSQL_USER="$MYSQL_USER" \
  -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  -p 3306:3306 \
  -v "$REPO_DIR/database/schema.sql":/docker-entrypoint-initdb.d/schema.sql:ro \
  mysql:8.0

echo "✅ MySQL Docker container started with schema applied."