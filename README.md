# bkup

A file backup utility.

## Installation
```
if [ $(md5sum bkup.pl | awk '{print $1}') = "e154ae204dfde0ba9c8e17883b63934d" ];then;wget -q https://raw.githubusercontent.com/loweryaustin/bkup/bkup.pl ; perl bkup.pl --install;else echo "MD5SUM does not match. Software may have been tampered with. Installation cancelled.";fi
```
