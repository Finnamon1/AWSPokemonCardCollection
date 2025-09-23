#!/usr/bin/env bash
set -e

# 1. Update packages
sudo yum update -y
sudo yum install -y wget git

# 2. Install MySQL 8 from Amazon repos
sudo amazon-linux-extras enable mysql8.0
sudo yum install -y mysql mysql-server

# 3. Enable and start MySQL
sudo systemctl enable mysqld
sudo systemctl start mysqld

# 4. Clone repo to get schema.sql
if [ ! -d /home/ec2-user/pokemon-app ]; then
  git clone https://github.com/Finnamon1/AWSPokemonCardCollection.git /home/ec2-user/pokemon-app
fi

# 5. Configure MySQL for external access
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/my.cnf
sudo systemctl restart mysqld

# 6. Set root password & create app user
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootpassword'; FLUSH PRIVILEGES;"
sudo mysql -u root -prootpassword -e "CREATE USER IF NOT EXISTS 'pokeuser'@'%' IDENTIFIED BY 'pokepass';"
sudo mysql -u root -prootpassword -e "GRANT ALL PRIVILEGES ON *.* TO 'pokeuser'@'%'; FLUSH PRIVILEGES;"

# 7. Apply schema
if [ -f /home/ec2-user/pokemon-app/database/schema.sql ]; then
  sudo mysql -u root -prootpassword < /home/ec2-user/pokemon-app/database/schema.sql
else
  echo "⚠️ schema.sql not found in /home/ec2-user/pokemon-app/database/"
fi
echo "✅ MySQL setup complete."