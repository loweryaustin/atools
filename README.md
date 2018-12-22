# bkup

A file backup utility.

## Installation
```
wget -q https://raw.githubusercontent.com/loweryaustin/bkup/master/bkup.pl ; if [ $(md5sum bkup.pl | awk '{print $1}') = "848c0e8132109889bde1dcd791f0ceda" ];then; perl bkup.pl --install;else echo "MD5SUM does not match. Software may have been tampered with. Installation cancelled.";fi
```
