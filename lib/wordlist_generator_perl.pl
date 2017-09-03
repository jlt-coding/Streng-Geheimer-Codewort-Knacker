use strict;
use warnings;
use Path::Tiny;

# Define variables
my $data_path = path('..')->absolute . "/data";
my $source_file = $data_path . '/ngermandict.txt';
my $result_file = $data_path . '/five_letter_word_list_perl.txt';
my @dict_content;
my @five_letter_words;

# Open the dictionary file
open (my $fh_input, '<', $source_file) or 
	die "Cannot open file $source_file: $!.";

# Save content in array	
while (my $line = <$fh_input>) {
	chomp($line);
	push(@dict_content, "$line");
}

# Isolate the words that are 5 letters long, and include all those that do not contain ö, ü, ä in an array
# ö, ü, ä are read as "ae", "oe", "ue"
foreach my $word (@dict_content) {
	if (length($word) == 5) {
		$word = lc($word);
		if ($word !~ /ä|ü|ö/) {
			push(@five_letter_words, $word . "\n");
		}
	}
}

# Isolate the words that are 6 letters long, and include all those that do contain ö, ü, ä in the same array as before
foreach my $word (@dict_content) {
	if (length($word) == 6) {
		$word = lc($word);
		if ($word =~ /ä|ö|ü/) {
			push(@five_letter_words, lc($word) . "\n");
		}
	}
}

# Write to file
open (my $fh_output, '>', $result_file) or
	die "Cannot write to $result_file, $!.";
	
print $fh_output "@five_letter_words";