#!/usr/bin/perl
use strict;
use warnings;
use File::Copy qw(cp);
use File::Spec::Functions;
use POSIX qw(strftime);

###################################
# BKUP - Version 0.6.1            #
#                                 #
# Released under the MIT License  #
# By Austin Lowery                #
###################################

## Handle Input
my $input = shift or die "Usage: $0 FILENAME\n";
my $origPath = validateFilePath($input);
my ($volume, $dirs, $fileName) = File::Spec->splitpath($origPath);

## Setup
my $date = strftime "%F %H:%M:%S", localtime;
my $epoch = time();
my $user = $ENV{LOGNAME} || $ENV{USER} || getpwuid($<);
my $homeDir = $ENV{HOME} || (getpwuid $<)[7];
my $backupDir = $homeDir."/bkups/";
my $logPath = $backupDir.'bkup.log';
my $destPath = $backupDir.$fileName."-".$epoch;
open my $fhout, ">>", $logPath or die $!;

## Do the thing
mkdir ($backupDir, 0755);
cp $origPath, $destPath;
select $fhout;
print $fhout $date." ".$user." ".$origPath." -> ".$destPath."\n";
select STDOUT;
print "Copied ".$origPath." -> ".$destPath;

## Subs
sub validateFilePath {

	my ($input) = @_;
	
	if (! -e $input) {

		die ("$input not found.");
	} elsif (-d $input){

		die ("$input is a directory. Directory support is planed in feature #48. Check pm.austinlowery.com for more info.");	
	} elsif (! file_name_is_absolute($input)) {
		
		return File::Spec->rel2abs($input);
	} else {
		
		return $input
	}	
}

