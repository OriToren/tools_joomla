#!/bin/bash
echo "=== Joomla Cleanup (WARNING: DESTRUCTIVE!) ==="

read -p "This will DELETE all containers and data! Continue? (y/n): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  docker stop joomla joomla-db
  docker rm joomla joomla-db
  docker volume rm joomla-mysql-data joomla-www-data
  docker network rm workdocker
  echo "All Joomla containers and volumes removed."
fi
EOF
