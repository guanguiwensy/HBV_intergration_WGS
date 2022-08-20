#!/usr/bin/perl
use strict;
use warnings;
my $interesting=$ARGV[1];
my %name_with_interesting;
open (SAM, $ARGV[0]);
while(<SAM>){
   chomp;
   my $head=$_=~ m/^@/;
   print "$_\n" if($head);
   if(!$head){
        my($name,$flag,$chr_first,$position_first,
		$MAPQ,$cigar,$chr_mate,
		$position_second,$annotion)=split(/\t/,$_,9);
		if($name_with_interesting{$name}){
		    print "$_\n";
		}
		elsif($chr_first eq $interesting || $chr_mate eq $interesting){
		    print "$_\n";
			$name_with_interesting{$name}=1;
		}
		 
   }
}
close SAM;
