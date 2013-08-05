WordPress Database
===========
***

About
-----

This is a simple Rakefile for automatic database backups, and an easy way to restore backups. This only works with Bluehost accounts.

Setup
-----

For this app to function in the Rakefile in this project needs to be copied to the home directory on bluehost:

```bash
scp Rakefile user@bluehost:
```

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
0 1 * * * `which rake` wp:backup:daily
0 2 * * 0 `which rake` wp:backup:weekly
```

Copyright
---------

Copyright (c) 2013 Boondock Walker.