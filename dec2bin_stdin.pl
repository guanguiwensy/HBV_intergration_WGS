#!/usr/bin/perl
use strict;
use warnings;
print "Enter a number to convert: ";
chomp(my $input = <STDIN>);
sub dec2bin{
	my $decimal=$_[0];
	my $i=1;
	my $ans;
    my $remainder;
    print "$decimal\n";
	while($decimal > 0){
    $remainder = $decimal%2;
    $ans+=$remainder*$i;
    $i=$i*10;
    $decimal >>= 1;
    }
    print "$ans\n";
	my $length=12-length($ans);
    print "$length\n";
	$ans="0"x$length."$ans";
}
print &dec2bin($input)."\n";
