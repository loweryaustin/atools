#!/usr/bin/perl
use strict;
use warnings;
use File::Copy qw(cp);
use File::Copy qw(move);
use POSIX qw(strftime);
use File::Spec::Functions;
use File::Path qw(make_path);
use Getopt::Long qw(GetOptions);
Getopt::Long::Configure qw(gnu_getopt);

###################################
# bkup - Version 0.6.1            #
#                                 #
# Released under the MIT License  #
# By Austin Lowery                #
###################################

## Setup
my $date = strftime "%F %H:%M:%S", localtime;
my $epoch = time();
my $user = $ENV{LOGNAME} || $ENV{USER} || getpwuid($<);
my $homeDir = $ENV{HOME} || (getpwuid $<)[7];
my $defaultFallbackInstallDir = "$homeDir/bkups/bin/";
my $backupDir = $homeDir."/bkups/";
my $logPath = $backupDir.'bkup.log';
open my $fhout, ">>", $logPath or die $!;

## Options
my $install;
my $installDir = "/usr/local/bin/";

## Handle Input
GetOptions(
    'install|i' => \$install,
    'install-dir=s' => \$installDir,
) or die "No help built in. You're on your own for now.\n";

if ($install){
	installBkup();	
}

my $input = shift or die "Usage: $0 FILENAME\n";
my $origPath = validateFilePath($input);
my ($volume, $dirs, $fileName) = File::Spec->splitpath($origPath);
my $destPath = $backupDir.$fileName."-".$epoch;

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

sub installBkup {
	if ($installDir eq $defaultFallbackInstallDir) { make_path($installDir); }; # Since this is the default fallback directroy, we'll create it to faciliate the quick and easy one step installation process that this script must posess.
	if (! -e $installDir) { die("$installDir does not exist. Please create it or choose a different directory")};
	if (! -d $installDir) { die("$installDir is not a directory. You must use a directory with the --install-dir flag.")};
	if (! -w $installDir) { die("You do not have permission to install bkup to $installDir . Try using sudo. If you don't have sudo access, you can use --install-dir [Path to install Dir] in additon to the install flag to specify a directory that you have permission to write to.\n");};
	
	my $installDest = $installDir."bkup"; 
	if (-e $installDest) { die("bkup is already installed at $installDest\n");};
			
	cp ($0, $installDest);
	chmod 0755, $installDest;
	print "Installed to $installDest";
	exit;
}
