#!/usr/bin/env bash
set -e

# 1 Update package list
sudo apt-get update

# 2 Install MySQL server and client
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server mysql-client

# 3 Configure MySQL to accept external connections
sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

# 4 Secure root user with password authentication
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootpassword'; FLUSH PRIVILEGES;"

# 5 Create dedicated app user
sudo mysql -u root -prootpassword -e "CREATE USER IF NOT EXISTS 'pokeuser'@'%' IDENTIFIED BY 'pokepass';"
sudo mysql -u root -prootpassword -e "GRANT ALL PRIVILEGES ON *.* TO 'pokeuser'@'%'; FLUSH PRIVILEGES;"

# 6 Apply schema
if [ -f /vagrant/database/schema.sql ]; then
  sudo mysql -u root -prootpassword < /vagrant/database/schema.sql
else
  echo "⚠️ schema.sql not found in /vagrant/database/"
fi
