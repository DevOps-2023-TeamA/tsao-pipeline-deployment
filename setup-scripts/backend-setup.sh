#!/bin/bash
# Check if the secret key argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <SECRET_KEY>"
    exit 1
fi

sudo apt update
sudo apt install -y nginx
sudo apt install -y mysql-server

sudo rm -rf /usr/bin/go
sudo snap install go --classic

sudo ufw allow 22/tcp
sudo ufw allow 8000/tcp
sudo ufw allow 8001/tcp
sudo ufw allow 8002/tcp

cd /

# Clone DB repository

git clone https://github.com/DevOps-2023-TeamA/tsao-db.git /root/tsao-db

# Create new user "user"
sudo mysql -e "CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Create new database "demo"
sudo mysql -e "CREATE DATABASE demo;"

# Create tables and DB for tsao
sudo mysql --protocol=TCP -h localhost -P 3306 --user=user --password=password demo < /root/tsao-db/create_table.sql

# Insert data into table for tsao
sudo mysql --protocol=TCP -h localhost -P 3306 --user=user --password=password tsao < /root/tsao-db/insert_data.sql

# Set up backend
git clone http://github.com/DevOps-2023-TeamA/tsao-backend-svc.git /root/tsao-backend-svc

cd /root/tsao-backend-svc

echo "SECRET_KEY=$1" > .env

go run microservices/auth/*.go -sql "user:password@tcp(127.0.0.1:3306)/tsao" &
go run microservices/accounts/*.go -sql "user:password@tcp(127.0.0.1:3306)/tsao" &
go run microservices/records/*.go -sql "user:password@tcp(127.0.0.1:3306)/tsao" &