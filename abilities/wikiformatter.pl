#!/usr/bin/perl

open FILIN, "wikiabilities.txt" or die $!;
open FILOUT, ">formattedabil.txt" or die $!;

my $file;

while ($l = <FILIN>) {
	$file .= $l;
}

my @abilities = ();
my $letter;
@brokenfile = split("\n\n", $file);

sub writearray {
	$count = ++$#abilities;
	
	my $first = int($count / 3);
	my $second = int($count / 3);
	my $third = int($count / 3);
	
	if ($count % 3 == 2) {
		$first++;
		$third++;
	} elsif ($count % 3 == 1) {
		$second++;
	}
	
	print FILOUT "[[table style=\"margin: 0 10px; border-collapse:collapse; width:100%\"]]\n[[row]]\n[[cell style=\"padding: 10px; border: 1px solid silver; width: 33%; vertical-align:top\"]]\n\n";
	print FILOUT join("\n\n", splice(@abilities, 0, $first));
	print FILOUT "\n\n[[/cell]]\n[[cell style=\"padding: 10px; border: 1px solid silver; width: 34%; vertical-align:top\"]]\n\n";
	print FILOUT join("\n\n", splice(@abilities, 0, $second));
	print FILOUT "\n\n[[/cell]]\n[[cell style=\"padding: 10px; border: 1px solid silver; width: 33%; vertical-align:top\"]]\n\n";
	print FILOUT join("\n\n", @abilities);
	print FILOUT "[[/cell]]\n[[/row]]\n[[/table]]\n\n";
	
	@abilities = ();
}

foreach my $line (@brokenfile) {
	if ($line =~ m/^\+ \w$/) {
		print $line . "\n";
		writearray if @abilities;
		$letter = substr $line, -1, 1;
		print FILOUT "$line\n\n";
		next;
	}
	
	push @abilities, $line;
}

writearray;

close FILIN;
close FILOUT;