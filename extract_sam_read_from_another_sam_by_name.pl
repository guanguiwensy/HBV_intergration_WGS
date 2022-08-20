#!/usr/bin/perl
use strict;
use warnings;
open (SAM1, $ARGV[0]);

my %list;
while(<SAM1>){
   chomp;
   my $head=$_=~ m/^@/;
   if(!$head){
	   my($name,$annotion)=split(/\t/,$_,2);
	   $list{$name}=1;
   }
}
close SAM1;

open (SAM2, $ARGV[1]);

while(<SAM2>){
   chomp;
   my $head=$_=~ m/^@/;
   print "$_\n" if($head);
   if(!$head){
	   my($name,$annotion)=split(/\t/,$_,2);
	   print "$_\n" if($list{$name});
   }
}
close SAM2;
