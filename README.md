WordPress Database
===========
***

About
-----

This is a simple Rakefile for automatic database backups, and an easy way to restore backups.

Setup
-----

Simply FTP the Rakefile to the site's root directory of your WordPress install.

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

Copyright
---------

Copyright (c) 2013 Boondock Walker.