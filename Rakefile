namespace :wp do
  
  namespace :backup do
  
    CONFIG  = File.read("public_html/wp-config.php")
    DB_NAME = /DB_NAME', '([^']+)'/.match(CONFIG)[1]
    DB_USER = /DB_USER', '([^']+)'/.match(CONFIG)[1]
    DB_PASSWORD = /DB_PASSWORD', '([^']+)'/.match(CONFIG)[1]

    # Check for backup directories
    unless File.directory?('db/backups')
      puts "The directory '~/db/backups' does not exists. Creating directory '~/db/backups'"
      `mkdir -p db/backups`
    end

    desc "Create a backup of WordPress"
    task :create do

      if File.directory? 'db/backups'
      puts "Creating backup..."      
      backup = %x{mysqldump -u #{DB_USER} -p#{DB_PASSWORD} #{DB_NAME} >> ~/db/backups/#{Time.now.strftime("%Y%m%d%H%M%S")}.sql}
      
      # Keeping only last 5 backups
      puts "Cleaning up backups..."
      %x{ls -1dt ~/db/backups/* | tail -n +6 |  xargs rm -rf}

      # Backup Done!
      puts "Backup done!"
    end   

    desc "Restore latest backup"
    task :restore do      
      latest_backup = Dir.glob('~/db/backups/*.sql').last      
      puts "Restoring to latest backup (#{latest_backup}) ..."
      #puts `mysql -u #{DB_USER} -p#{DB_PASSWORD} #{DB_NAME} < #{latest_backup}`
    end    
  end

end