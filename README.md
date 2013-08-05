WordPress Database
===========
***

About
-----

This is a simple Rakefile for automatic database backups, and an easy way to restore backups. This only works with Bluehost accounts.

Setup
-----

For this app to function in the Rakefile in this project needs to be copied to the home directory on bluehost:

1. Create a [Stripe.com](https://stripe.com/) account.

2. Create a [Parse.com](https://parse.com/) account. Once you have the Parse.com account you will need to make a "Parse App" for each environment you wish to use.

***The below example files should be replaced and updated with the correct credentials***

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