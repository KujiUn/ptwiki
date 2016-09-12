#!/usr/bin/perl

@columns = qw(
	Ability
	Duration
	Trigger
	Target
	Effect
);

open FILEIN, "abilities.txt" or die $!;
open FILEOUT, ">", "outabilities.csv" or die $!;

print FILEOUT join(",", @columns) . "\n";

my %ability = {};
my $first = 1;
my $duration = 0;
my $effect = 0;
my $trigger = 0;

sub writeAbility {
	print FILEOUT "\"$ability{'Ability'}\",\"$ability{'Duration'}\",\"$ability{'Trigger'}\",\"$ability{'Target'}\",\"$ability{'Effect'}\"\n"; #this could be better
	%ability = {};
	$effect = 0;
}

sub writeData {
	my @data = split(": ", $_[0]);
	$ability{$data[0]} = "" if not $ability{$data[0]};
	$ability{$data[0]} .= $data[1];
}

while (my $line = <FILEIN>) {
	$line =~ s/[\t\n\f\r]//g;
	$line =~ s/^\s*//;
	next if $line =~ m/Ability List/ or $line =~ m/\d{3}/ or $line =~ m/Indices and Reference/;
	
	if (($effect or $trigger) and not ($line =~ m/Ability: / or $line =~ m/Effect: /)) {
		$line = "Effect:  " . $line if $effect;
		$line = "Trigger:  " . $line if $trigger;
	}
	
	if ($line =~ m/Effect: /) {
		$effect = 1;
		$duration = 0;
		$trigger = 0;
	}
	
	$trigger = 1 if $line =~ m/Trigger: /;
	
	if ($duration) {
		$line = "Duration: " . $line;
		$duration = 0;
	}
	
	if ($line =~ m/Ability: /) {
		writeAbility if not $first;
		$effect = 0;
		$first = 0;
		$duration = 1;
	}
	
	writeData $line;
}

writeAbility;

print "\n";

close FILEIN;
close FILEOUT;