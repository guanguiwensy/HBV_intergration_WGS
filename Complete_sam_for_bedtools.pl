#!/usr/bin/perl
use strict;
use warnings;
my %sup;
my %read_mate;
open (SAM, $ARGV[0]);
while(<SAM>){
   chomp;
   my $head=$_=~ m/^@/;
   print "$_\n" if($head);
   if(!$head){
        my($name,$flag,$chr_first,$position_first,
		$MAPQ,$cigar,$chr_mate,
		$position_second,$annotion)=split(/\t/,$_,9);
		$flag=&explain_flag($flag);
		my @flag_explain=split(//,$flag);
		if ($flag_explain[0] eq "1"){
			if($flag_explain[5] eq "1"){
				$sup{$name}=$_;
			}
			else{
				$sup{$name.2}=$_;
			}
		}
		elsif ($flag_explain[5] eq "0"){
			print "$_\n";
			$read_mate{$name}=$_;
		}
		else{
			print "$_\n";
			$read_mate{$name.2}=$_;
		}
   }
}
foreach my $key ( keys %sup ){
	print "$sup{$key}\n";
	print "$read_mate{$key}\n" if($read_mate{$key});
    print "not exist\n" if(!$read_mate{$key});
}

close SAM;

sub explain_flag{
	my $decimal=$_[0];
	my $i=1;
	my $ans;
    my $remainder;
	while($decimal > 0){
    $remainder = $decimal%2;
    $ans+=$remainder*$i;
    $i=$i*10;
    $decimal >>= 1;
    }
	my $length=12-length($ans);
	$ans="0"x$length."$ans";
}
