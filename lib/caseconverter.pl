use strict;
use warnings;

open (my $fh_input, '<', 'final.txt');

my @new_cont;
while (my $line = <$fh_input>) {
	$line = lc($line);
	push (@new_cont, $line);
}

close $fh_input;

open (my $fh_output, '>', 'new_final.txt');
print $fh_output "@new_cont";