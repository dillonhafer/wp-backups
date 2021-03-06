WordPress Backups
===========
***

About
-----

This is a simple bash script for automatic database and file backups. It looks at wp-config.php for the database configuration needed.

It does four things:

1. Create a MySQL dump into wp-backups/daily directory.
2. Create a .tar.gz file of the site into wp-backups/daily directory.
3. Only on Sundays, the weekly task copies the latest .sql file and .tar.gz file from the daily directory into the wp-backups/weekly directory.
4. Keeps only the last five backups in daily and weekly folders.

Setup
-----

Simply FTP the script to the site's root directory of your WordPress install and make it executable (i.e. chmod +x wp-backup.sh), and then create a cron job to run it everyday.

Script's Tasks
----------

**Creates a database and website backup.**

```bash
./wp-backup.sh
```

**Setup weekly/daily crontab**

```bash
chmod +x /path/to/wordpress/site/wp-backup.sh
crontab -e
```

**Crontab format**

```bash
0 0 * * * cd /path/to/wordpress/site/wp-backup.sh && /path/to/wordpress/site/wp-backup.sh
```

## CONTRIBUTING:

* Fork WordPress Backups
* Create a topic branch - `git checkout -b my_branch`
* Rebase your branch so that all your changes are reflected in one
  commit
* Push to your branch - `git push origin my_branch`
* Create a Pull Request from your branch, include as much documentation
  as you can in the commit message/pull request, following these
[guidelines on writing a good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
* That's it!

## License

WordPress Backups is Copyright © 2013 Dillon Hafer. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
