#!/usr/bin/perl
use 5.010_000;
use warnings;
use strict;
use POSIX;
use Excel::Writer::XLSX;

#also see http://search.cpan.org/~jmcnamara/Excel-Writer-XLSX/lib/Excel/Writer/XLSX.pm#write_string%28_$row,_$column,_$string,_$format_%29
#and http://search.cpan.org/~jmcnamara/Excel-Writer-XLSX/lib/Excel/Writer/XLSX.pm#Example_5
#

if($#ARGV ne 1)
{
print "\n Usage: txt2xls \n Example: txt2xls \"|\" *.psv\n\n";
}


my $wb;
my @files = @ARGV[1..$#ARGV];

my $del;
if($ARGV[0] =~ /\\t|\t/){
	$del="\t";
}else{
	$del = $ARGV[0];
}
	
my $ext = ".xlsx";
		
for my $file (@files){
	TableToXlsx("tsv"=>$file,"sep"=>$del);
}
