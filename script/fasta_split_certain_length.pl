#!/usr/bin/perl
use strict;
use warnings;
$/='>';
open (FASTA,$ARGV[0]);
my $splitLength=$ARGV[1];
while(<FASTA>){
        chomp;
        my($name,$seq)=split(/\n/,$_,2);
        $seq=~ s/\n//g;
        my $length=length($seq);
		print "\>$name\n" if($seq);
		&splitStr($seq,$splitLength);       
}
close(FASTA);

sub splitStr{
	my ($strtmp,$splitLength)=@_;
	my $strLength=length $strtmp;
	for(my $i = 0; $i < $strLength; $i += $splitLength){
		if($strLength < ($i + $splitLength)){
			print substr($strtmp,$i)."\n";
		}
		else{
			print substr($strtmp,$i,$splitLength)."\n";
		}

	}
}
