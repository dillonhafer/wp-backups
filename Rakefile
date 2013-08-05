class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def pink
    colorize(35)
  end
end

namespace :wp do

  namespace :backup do

    # Generate config variables by reading the wordpress config file
    CONFIG  = File.read("wp-config.php")
    DB_NAME = /DB_NAME', '([^']+)'/.match(CONFIG)[1].chomp
    DB_USER = /DB_USER', '([^']+)'/.match(CONFIG)[1].chomp
    DB_PASSWORD = /DB_PASSWORD', '([^']+)'/.match(CONFIG)[1].chomp
    COMMAND_TIME = Time.now.strftime("%Y%m%d%H%M%S")

    dump_command = "mysqldump -u #{DB_USER} -p#{DB_PASSWORD} #{DB_NAME} > wp-backups/backups/#{COMMAND_TIME}.sql"
    
    desc "Create a daily backup of WordPress"
    task :daily do      
      # Check for backup directories and create them if they don't exist
      unless File.directory?('wp-backups/daily')
        puts "The directory 'wp-backups/daily' does not exists. Creating directory 'wp-backups/daily'".red
        `mkdir -p wp-backups/daily`
      end
      
      # Dump the database
      puts "  ** Creating backup...".green
      puts "  ** Command:".yellow + " #{dump_command}"
      `mysqldump -u #{DB_USER} -p#{DB_PASSWORD} #{DB_NAME} > wp-backups/daily/#{Time.now.strftime("%Y%m%d%H%M%S")}.sql`
      
      # Keeping only last 5 backups
      puts "  ** Cleaning up backups...".yellow
      %x{ls -1dt wp-backups/daily/*.sql | tail -n +6 |  xargs rm -rf}      
      puts "Backup complete!".pink

      # Deny directory listing apache      
      puts "  ** Generating htaccess file".green
      `echo "Options -Indexes" > wp-backups/.htaccess`
    end   

    desc "Create a weekly backup of WordPress"
    task :weekly do
      # Check for backup directories and create them if they don't exist
      unless File.directory?('wp-backups/weekly')
        puts "The directory 'wp-backups/weekly' does not exists. Creating directory 'wp-backups/weekly'".red
        `mkdir -p wp-backups/weekly`
      end

      # Copy the latest daily backup to the weekly folder
      puts "  ** Creating backup...".green
      puts "  ** Command:".yellow + " ls -1rt wp-backups/daily/*.sql | tail -n -1"
      `cp \`ls -1rt wp-backups/daily/*.sql | tail -n -1\` wp-backups/weekly`
      
      # Keeping only last 5 backups
      puts "  ** Cleaning up backups...".yellow
      %x{ls -1dt wp-backups/weekly/*.sql | tail -n +6 |  xargs rm -rf}      
      puts "Backup complete!".pink
    end

    desc "Restore latest backup"
    task :restore do
      # Get the latest file by date
      latest_backup = Dir.glob('~/wp-backups/backups/*.sql').last      
      puts "  ** Restoring to latest backup".green + " (#{latest_backup})".yellow + " ...".green
      #`mysql -u #{DB_USER} -p#{DB_PASSWORD} #{DB_NAME} < #{latest_backup}`
      puts "Restore complete!".pink
    end    
  end

end
