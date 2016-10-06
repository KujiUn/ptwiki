#!/usr/bin/perl

open FILIN "pokedex-source.txt" or die $!;
open FILOUT ">pokedex.csv" or die $!;

my %Pokemon = {};
my $mode;
my @basestats = ();

sub printPokemon {

}

while (my $line = <FILIN>) {
	chomp $line;
	if ($line =~ m/^[A-Z ]$/) {
		printPokemon;
		$Pokemon{'Name'} = $line;
	} elsif ($line =~ m/Base Stats/) {
		$mode = $line;
	} elsif ($line =~ m/Basic Information/) {
		$mode = $line;
		$Pokemon{'Base Stats'} = join(' / ', @basestats);
		@basestats = ();
	} elsif ($mode =~ m/Base Stats/) {
		my ($b1, $b2) = split(/: /,$line);
		push @basestats, $b2;
	}
}
