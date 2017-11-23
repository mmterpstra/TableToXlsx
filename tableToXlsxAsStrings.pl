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

my $ext=".xlsx";

for my $file (@files){
	my $xlsxfile=$file;
	$xlsxfile=~s/\.tsv$|\.csv$|\.tdv$|\.cdv$|\.txt$//g;
	$xlsxfile.=$ext;
	unlink($xlsxfile);
	open (TXTFILE, $file) or die "Cannot read '".$file."', check if file is present... and if specified correctly";
	
	
	my $workBook = Excel::Writer::XLSX->new($xlsxfile);
	print "$0: output file written to ".$xlsxfile."\n";
	my $workSheets;
	push(@{$workSheets},$workBook->add_worksheet());
	
	my $colmax=1024;
	while (<TXTFILE>) {
		chomp;
		my @t = split("$del");
	
		my $col = 0;
		for my $token (@t) {
			if(not(floor($col/$colmax) < scalar(@{$workSheets}) )){
				push(@{$workSheets},$workBook->add_worksheet());
			}

			$workSheets -> [floor($col/$colmax)] -> write_string(($.-1), $col%$colmax, $token);
			$col++;
		}
	}
	close(TXTFILE);
}
