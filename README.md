#bkup

A file backup utility.

## Installation
```
if [ $(md5sum bkup.pl | awk '{print $1}') = "5f25b20084ff883d6ce6c3d80baecea0" ];then;wget -q https://raw.githubusercontent.com/loweryaustin/bkup/one-command-install-91/bkup.pl; perl bkup.pl --install;else echo "MD5SUM does not match. Software may have been tampered with. Installation cancelled.";fi
```
