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

def db_dump(config)
  command_to_run = "mysqldump -u #{config[:db_user]} -p'#{config[:db_password]}' #{config[:db_name]} > wp-backups/daily/#{config[:time]}.sql"
  puts "  ** Creating backup...".green
  puts "  ** Command:".yellow + " #{command_to_run}"
  `#{command_to_run}`
  puts "  ** Finished".green
end

def zip_site(config)
  command_to_run = "tar -zcvf wp-backups/daily/#{config[:time]}.tar.gz ."
  puts "  ** Zipping site folder".green
  puts "  ** Command:".yellow + " #{command_to_run}"
  `#{command_to_run}`
  puts "  ** Finished".green
end

def check_for_directory(directory)
  puts "  ** Checking for backup directories...".yellow
  unless File.directory?("wp-backups/#{directory}")
    puts "The directory 'wp-backups/#{directory}' does not exists. Creating directory 'wp-backups/#{directory}'".red
    `mkdir -p wp-backups/#{directory}`
  end
  puts "  ** Finished".green
end

def keep_last_five(directory)
  puts "  ** Cleaning up backups...".yellow
  %x{ls -1dt wp-backups/#{directory}/*.sql | tail -n +6 |  xargs rm -rf}      
  %x{ls -1dt wp-backups/#{directory}/*.tar.gz | tail -n +6 |  xargs rm -rf}      
  puts "  ** Finished".green  
end

def create_htaccess
  unless File.exist?('wp-backups/.htaccess')
    puts "  ** Generating htaccess file".green
    `echo "Options -Indexes" > wp-backups/.htaccess`
  end
end

def weekly_copy
  db_command_to_run = "cp \`ls -1rt wp-backups/daily/*.sql | tail -n -1\` wp-backups/weekly"
  gz_command_to_run = "cp \`ls -1rt wp-backups/daily/*.tar.gz | tail -n -1\` wp-backups/weekly"
  puts "  ** Creating backups...".green
  puts "  ** Command:".yellow + " #{db_command_to_run}"
  `#{db_command_to_run}`
  puts "  ** Command:".yellow + " #{gz_command_to_run}"
  `#{gz_command_to_run}`
end  

namespace :wp do
  # Generate config variables by reading the wordpress config file
  config = {}

  wp_config            = File.read("wp-config.php")    
  config[:db_name]     = /DB_NAME', '([^']+)'/.match(wp_config)[1]
  config[:db_user]     = /DB_USER', '([^']+)'/.match(wp_config)[1]
  config[:db_password] = /DB_PASSWORD', '([^']+)'/.match(wp_config)[1]
  config[:time]        = Time.now.strftime("%Y%m%d%H%M%S")

  namespace :backup do
    desc "Create a daily backup of WordPress"
    task :daily do
      # Check for backup directories and create them if they don't exist
      check_for_directory('daily')
      
      # Dump the database
      db_dump(config)
      
      # Zip site folder
      zip_site(config)

      # Keeping only last 5 backups
      keep_last_five('daily')
         
      # Deny directory listing for apache      
      create_htaccess
    end   

    desc "Create a weekly backup of WordPress"
    task :weekly do
      # Check for backup directories and create them if they don't exist
      check_for_directory('weekly')

      # Copy the latest daily backup to the weekly folder
      weekly_copy
      
      # Keeping only last 5 backups
      keep_last_five('weekly')
    end
  end

  namespace :restore do
    desc "Restore latest backup"
    task :yesterday do
      # Get the latest file by date
      latest_backup = Dir.glob('wp-backups/daily/*.sql').last      
      puts "  ** Restoring to latest backup".green + " (#{latest_backup})".yellow + " ...".green
      `mysql -u #{config[:db_user]} -p'#{config[:db_password]}' #{config[:db_name]} < #{latest_backup}`
      puts "Restore complete!".pink
    end    
  end    

end
