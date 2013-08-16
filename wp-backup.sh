#!/bin/bash
# Check if running in WordPress directory
if [ ! -f wp-config.php ]; then    
  echo "This script must be run from the wordpress site root folder." ; exit 1
fi

# Setup variables
WP_USERNAME=$(grep -oEi "DB_USER', '[^']+"     wp-config.php | sed s/DB_USER\',\ \'//)
WP_DATABASE=$(grep -oEi "DB_NAME', '[^']+"     wp-config.php | sed s/DB_NAME\',\ \'//)
WP_PASSWORD=$(grep -oEi "DB_PASSWORD', '[^']+" wp-config.php | sed s/DB_PASSWORD\',\ \'//)
    WP_DATE=$(date +"%Y%m%d%H%M%S")

# Check for backup directory
mkdir -p wp-backups/daily
mkdir -p wp-backups/weekly

# Dump the database
mysqldump -u $WP_USERNAME -p$WP_PASSWORD $WP_DATABASE > wp-backups/daily/$WP_DATE.sql

# Zip site folder
tar -zcf wp-backups/daily/$WP_DATE.tar.gz --exclude=wp-backups .

# Create weekly if today is sunday
if [ $(date +%u) -gt 6 ] ; then  
  cp `ls -1rt wp-backups/daily/*.sql    | tail -n -1` wp-backups/weekly
  cp `ls -1rt wp-backups/daily/*.tar.gz | tail -n -1` wp-backups/weekly
fi

# Keep last five backups
ls -1dt wp-backups/daily/*.sql     | tail -n +6 | xargs rm -rf
ls -1dt wp-backups/daily/*.tar.gz  | tail -n +6 | xargs rm -rf

WEEKLY_FILES_EXIST=$(ls wp-backups/weekly | wc -l)
if [ $WEEKLY_FILES_EXIST -gt 0 ]; then      
  ls -1dt wp-backups/weekly/*.sql | tail -n +6 | xargs rm -rf
  ls -1dt wp-backups/weekly/*.tar.gz | tail -n +6 | xargs rm -rf
fi

# Create .htaccess file
echo "Options -Indexes" > wp-backups/.htaccess