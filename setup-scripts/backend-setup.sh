#!/bin/bash

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
