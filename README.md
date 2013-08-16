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

You will need to have Ruby >= 1.8.7 to use (I'm working on removing this dependancy). Simply FTP the script to the site's root directory of your WordPress install and make it executable (i.e. chmod +x wp-backup.sh), and then create a cron job to run it everyday.

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
0 0 * * * /path/to/wordpress/site/wp-backup.sh
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

## LICENSE:

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Copyright
---------

Copyright (c) 2013 Dillon Hafer.