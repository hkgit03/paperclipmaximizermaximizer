#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

my $mutationProb = 1 / 20;

# handle args
die "Too few args" if $#ARGV < 1;
my $childAmount = (defined $ARGV[2] and $ARGV[2] =~ /\d+/) ? abs($ARGV[2]) : 2; # at least two children are needed in order to recombine them
my $noSex = (defined $ARGV[3] and $ARGV[3] eq "--no-sex") ? 1 : 0;

# recombine parents
foreach my $child (1..$childAmount) {
	open(my $parent0, "<", "parent0.js") or die "Cannot open parent0.js";
	open(my $parent1, "<", "parent1.js") or die "Cannot open parent1.js";
	open(my $childFile, ">", "child$child.js") or die "Cannot open/create child $child";
	foreach my $line0 (<$parent0>) {
		my $line1 = (<$parent1>);
		my $parentChoice = $noSex ? 0 : int(rand(2));
		my $line = $parentChoice > 0 ? $line1 : $line0;
		if ( $line =~ /^(\s+)const\s([^ ]+)\s*=\s*(\d.*|true|false);/) {
			my ($pre, $identifier, $value) = ($1, $2, $3);
			if ( rand() lt $mutationProb ) {
				if ( $value =~ /^(true|false)$/ ) {
					$value = ($value eq "false") ? "true" : "false";
				}
				if ( $value =~ /^[\d\.]*$/ ) {
					if ( int(rand(2)) gt 0 ) {
						$value *= 1.5;
					} else {
						$value /= 2;
					}
				}
				# TODO: Consider rounding variables to integers which were ints in the first place
			}
			print $childFile $pre . "const " . $identifier . " = " . $value . ";\n";
		} else {
			print $childFile $line;
		}
	}
}
