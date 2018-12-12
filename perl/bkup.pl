#!/usr/bin/perl
use strict;
use warnings;
use File::Copy qw(move);


my $filename = shift or die "Usage: $0 FILENAME\n";
my $backupDir = '/root/bkups/';

mkdir ($backupDir, 0755);

move $filename, $backupDir.$filename;
