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

There are a number of rake tasks available to aid development and testing.

**Creates a new backup.**

```bash
rake wp:backup:create
```

**Restores database to latest backup.**

```bash
rake wp:backup:restore
```

**Setup weekly crontab**

TODO

Copyright
---------

Copyright (c) 2013 Boondock Walker.