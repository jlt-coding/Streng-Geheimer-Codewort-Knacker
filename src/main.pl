use strict;
use warnings;
use Path::Tiny;

# Define variables
my $data_path = path('..')->absolute . '/data';
my @word_list;
my $lettercount = 0;
my $input;
my @letterlist;

# Read the inputfile
open (my $fh_input, '<', $data_path . '/final.txt') or
	die "Cannot open file, $!.";
	
	
while (my $line = <$fh_input>) {
	chomp $line;
	push(@word_list, $line);
}

close $fh_input;
for my $i (1 .. 5) {
	$lettercount -= 1;
	@word_list = solution_finder(\@word_list, $lettercount);
}
print @word_list;

sub solution_finder{ # \@word_list, $lettercount
	my ($word, $count) = @_;
	my @words = @{$word};
	my @rest_of_list;
	print "Please enter the possible solutions for the current riddle, delimited by a comma after every letter.
(especially the last one e.g.: a,c,h,t,b,).
Alternatively, type [count] without brackets to get the number of remaining possible solutions.\n";

	$input = <STDIN>;
	chomp $input;
	$input = lc($input);
	
	while (substr($input, 1, 1) ne ',') {
		if ($input eq 'count') {
			print scalar(@word_list) . "\n";
			print "Please enter now the things:\n";
			$input = <STDIN>;
		} else {
			print "This input is incorrect, please try again";
			$input = <STDIN>;
			chomp $input;
		}
	}
	
	my @letters = split (/,/, $input);
	foreach my $buchstabe (@letters) {;
		foreach my $wort (@words) {
			$wort = lc($wort);
			if (substr($wort, $count, 1) eq $buchstabe) {
				push(@rest_of_list, $wort);
			}
		}
	}
	return @rest_of_list;
}