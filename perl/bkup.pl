#!/usr/bin/perl
use strict;
use warnings;
use File::Copy qw(cp);
use Cwd qw(cwd);
use POSIX qw(strftime);

 
## Set Options

## Handle Input
my $fileInput = shift or die "Usage: $0 FILENAME\n";

# TODO: input validataion
# TODO: allow for the use of full paths

## Setup
my $date = strftime "%F %H:%M:%S", localtime;

my $user = $ENV{LOGNAME} || $ENV{USER} || getpwuid($<);
my $homeDir = $ENV{HOME} || (getpwuid $<)[7];


my $backupDir = $homeDir."/bkups/";
my $logPath = $backupDir.'bkup.log';

my $cwd = cwd;
my $origPath = $cwd.$fileInput;
my $destPath = $backupDir.$fileInput;
mkdir ($backupDir, 0755);
open my $fhout, ">", $logPath or die $!;


## Do the thing
cp $fileInput, $destPath;
select $fhout;
print $fhout $date." ".$user." ".$origPath." -> ".$destPath;
select STDOUT;
print "Copied ".$origPath." -> ".$destPath;
