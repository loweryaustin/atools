# bkup

A file backup utility.

## Installation
```
wget -q https://raw.githubusercontent.com/loweryaustin/bkup/master/bkup.pl ; if [ $(md5sum bkup.pl | awk '{print $1}') = "6b1d4dbc289be84d50475530a82a1e9f" ];then; perl bkup.pl --install;else echo "MD5SUM does not match. Software may have been tampered with. Installation cancelled.";fi
```
