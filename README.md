#bkup

A file backup utility.

## Installation
```
wget -q https://raw.githubusercontent.com/loweryaustin/bkup/master/bkup.pl ; if [ $(md5sum bkup.pl | awk '{print $1}') = "5db50b4b01ca48f0b9dd80ee6d444d7a" ];then; perl bkup.pl --install;else echo "MD5SUM does not match. Software may have been tampered with. Installation cancelled.";fi
```
