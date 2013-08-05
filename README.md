WordPress Backups
===========
***

About
-----

This is a simple Rakefile for automatic database and file backups, and an easy way to restore backups too.

It does four things:

1. Create a MySQL dump into wp-backup/daily directory.
2. Create a .tar.gz file of the site into wp-backup/daily directory.
3. The weekly task copies the latest .sql file and .tar.gz file from the daily directory into the weekly directory.
4. Keeps only the last five backups in daily and weekly folders.

Setup
-----

Simply FTP the Rakefile to the site's root directory of your WordPress install. From there you can run the tasks manually, but it's best to set up a cron for daily and weekly backups.

Rake Tasks
----------

**Creates a daily backup.**

```bash
rake wp:backup:daily
```

**Creates a weekly backup.**

```bash
rake wp:backup:weekly
```

**Restores database to latest backup.**

```bash
rake wp:backup:restore
```

**Setup weekly/daily crontab**

```bash
crontab -e
```

**Crontab format**

```bash
0 0 * * * cd /path/to/wordpress/site /path/to/rake && wp:backup:daily
0 1 * * 0 cd /path/to/wordpress/site /path/to/rake && wp:backup:weekly
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