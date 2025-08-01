#!/bin/bash
echo "=== Joomla Docker Setup ==="

# Create network
docker network create workdocker 2>/dev/null || echo "Network already exists."

# Launch MySQL
docker run -d --name joomla-db \
  --network workdocker \
  -e MYSQL_ROOT_PASSWORD=mц-secret-pw \
  -e MYSQL_DATABASE=joomla_db \
  -e MYSQL_USER=joomla_user \
  -e MYSQL_PASSWORD=joomla_pass \
  -v joomla-mysql-data:/var/lib/mysql \
  mysql:5.7

# Launch Joomla
docker run -d --name joomla \
  --network workdocker \
  -p 8080:80 \
  -e JOOMLA_DB_HOST=joomla-db \
  -e JOOMLA_DB_USER=joomla_user \
  -e JOOMLA_DB_PASSWORD=joomla_pass \
  -e JOOMLA_DB_NAME=joomla_db \
  -v joomla-www-data:/var/www/html \
  joomla:4

echo "Joomla is running at http://localhost:8080"
EOF
