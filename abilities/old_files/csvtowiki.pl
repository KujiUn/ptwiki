#!/usr/bin/perl

open FILIN, "outabilities.csv" or die $!;
open FILOUT, ">wikiabilities.txt" or die $!;
my $init_letter = "";

while (my $line = <FILIN>) {
	my @ability = split(/","/, $line);
	chop $ability[4];
	$ability[0] =~ s/"//;
	$ability[4] =~ s/"//;
	
	my $firstletter = substr($ability[0], 0, 1);
	if (not $firstletter =~ m/$init_letter/) {
		$init_letter = $firstletter;
		print FILOUT "\+ $firstletter\n\n";
	}
	
	print FILOUT "[[div style=\"border:solid 1px #999999; background:#F6F6F0; padding:5px; margin-bottom: 10px;\"]]\n**$ability[0]**\n$ability[1]\n";
	print FILOUT "**Trigger:** $ability[2]\n" if $ability[2];
	print FILOUT "**Target:** $ability[3]\n" if $ability[3];
	print FILOUT "**Effect:** $ability[4]\n[[/div]]\n\n";
}

close FILIN;
close FILOUT;
