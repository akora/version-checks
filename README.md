
The script iterates through a list of packages and first checks whether they are installed at all or not. If a package is installed then it checks its path and version number.

It then displays the information in columns.

Example output:

``` shell
****************************** Version checks ****************************
python         2.7.6                            /usr/bin/python
perl           5.18.2                           /usr/bin/perl
ruby           2.0.0                            /usr/bin/ruby
php            5.5.14                           /usr/bin/php
bash           3.2.57                           /bin/bash
git            2.2.1                            /usr/local/git/bin/git
java           1.8.0_25        (Oracle)         /usr/bin/java
node           ------                           not installed
npm            ------                           not installed
```

This script can be included in your `.profile` or `.bash_profile` to run it at each SSH logins.

#### Tested on

* Mac OS X Yosemite 10.10.2
* Debian 7.8
* Ubuntu 14.10 32-bit with both Oracle Java & OpenJDK
* Ubuntu 14.10 64-bit with both Oracle Java & OpenJDK
