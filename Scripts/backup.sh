#!/bin/bash
echo "=== Joomla Backup ==="

BACKUP_DIR="./backups"
mkdir -p "$BACKUP_DIR"
DATE=$(date +"%Y%m%d")
docker exec joomla-db sh -c 'exec mysqldump --all-databases -uroot -p"mц-secret-pw"' > "$BACKUP_DIR/joomla_db_$DATE.sql"
docker run --rm -v joomla-www-data:/source -v "$(pwd)/$BACKUP_DIR:/backup" alpine \
  tar cvf "/backup/joomla_files_$DATE.tar" -C /source .
echo "Backups saved to $BACKUP_DIR/"
EOF
