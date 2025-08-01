#!/bin/bash
echo "=== Joomla Restore ==="

read -p "Enter backup date (e.g., 20230815): " DATE

# Restore database
docker exec -i joomla-db sh -c 'exec mysql -uroot -p"mц-secret-pw"' < "./backups/joomla_db_$DATE.sql"

# Restore files
docker run --rm -v joomla-www-data:/target -v "$(pwd)/backups/joomla_files_$DATE.tar:/backup.tar" alpine \
  tar xvf /backup.tar -C /target --strip 1

echo "Restored backup from $DATE. Restarting containers..."
docker restart joomla-db joomla
EOF
