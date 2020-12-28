
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

The macOS version of this script is now maintained on GitLab: https://gitlab.com/AndrasKora/macos-shell-version-checks

#### Tested on

* Ubuntu 20.04.1 LTS (Focal Fossa) 64-bit
