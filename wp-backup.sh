#!/bin/bash
WP_USERNAME=$(ruby -e "puts /DB_USER', '([^']+)'/.match(File.read('wp-config.php'))[1]")
WP_DATABASE=$(ruby -e "puts /DB_NAME', '([^']+)'/.match(File.read('wp-config.php'))[1]")
WP_PASSWORD=$(ruby -e "puts /DB_PASSWORD', '([^']+)'/.match(File.read('wp-config.php'))[1]")
WP_DATE=$(date +"%Y%m%d%H%M%S")

# Check for backup directory
mkdir -p wp-backups/daily
mkdir -p wp-backups/weekly

# Dump the database
mysqldump -u $WP_USERNAME -p$WP_PASSWORD $WP_DATABASE > wp-backups/daily/$WP_DATE.sql

# Zip site folder
tar -zcf wp-backups/daily/$WP_DATE.tar.gz --exclude=wp-backups .

# Create weekly if today is sunday
if [[ $(date +%u) -gt 6 ]] ; then  
  cp `ls -1rt wp-backups/daily/*.sql | tail -n -1` wp-backups/weekly
  cp `ls -1rt wp-backups/daily/*.tar.gz | tail -n -1` wp-backups/weekly
fi

# Keep last five backups
ls -1dt wp-backups/daily/*.sql | tail -n +6 |  xargs rm -rf
ls -1dt wp-backups/daily/*.tar.gz | tail -n +6 |  xargs rm -rf
ls -1dt wp-backups/weekly/*.sql | tail -n +6 |  xargs rm -rf
ls -1dt wp-backups/weekly/*.tar.gz | tail -n +6 |  xargs rm -rf

# Create .htaccess file
echo "Options -Indexes" > wp-backups/.htaccess