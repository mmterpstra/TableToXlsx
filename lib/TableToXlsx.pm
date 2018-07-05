package TableToXlsx;

use 5.006;
use strict;
use warnings;
use POSIX;
use Excel::Writer::XLSX;
require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use pipeline-util ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
#our %EXPORT_TAGS = ( 'all' => [ qw(
#	'TargetVcfReAnnotator'
#) ] );

#our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	ConvertToXlsx
);


=head1 NAME

TableToXlsx - The great new TableToXlsx!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.3.0';


=head1 SYNOPSIS

Lazy function to convert your table to xlsx file. This also provides the 'tableToXlsx.pl' Commandline interface tool with similar behavior.

Code example

    use TableToXlsx;
    system("echo -e 'SEPT5\tGENE' > test.tsv");
    TableToXlsx("tsv"=>"test.tsv","sep"=>"\t",'writestring'=> 1);
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 ConvertToXlsx

Converts the input table to xlsx.

use
	ConvertToXlsx("tsv"=>$file,"sep"=>$del,'writestring'=> 1);

writestring	Default action is to write the data and let excel interpret it.
		 set this to any other variable to write vales as string.

tsv		This sets the input file for conversion.



=cut

sub ConvertToXlsx {
	my $self;%{$self}=@_;	
	my $xlsxfile;
	$xlsxfile = $self -> {"xlsx"} or $xlsxfile = $self -> {"tsv"};
	my $file =  $self -> {"tsv"};
	my $ext = '.xlsx';
	my $del = $self -> {"sep"};
	#1024 is the max amount of columns of libreoffice with > $colmax the table in split between as much sheets as needed.
	my $colmax=1024;
	if($self -> {"colmax"} && $self -> {"colmax"} > 0){
		$colmax = $self -> {"colmax"};
	}
	#max no of rows to throw an error
	my $rowmax=1048576;
	if($self -> {"rowmax"} && $self -> {"rowmax"} > 0){
		$rowmax = $self -> {"rowmax"};
	}
	
	my $writestring = 0;
	$writestring = $self -> {'writestring'} if(defined($self -> {'writestring'}));
	
	$xlsxfile=~s/\.tsv$|\.csv$|\.tdv$|\.cdv$|\.txt$//g;
	$xlsxfile.=$ext;
	unlink($xlsxfile);
	open (TXTFILE, $file) or die "Cannot read '".$file."', check if file is present... and if specified correctly";
	
	
	my $workBook = Excel::Writer::XLSX->new($xlsxfile);
	print "$0: output file written to ".$xlsxfile."\n";
	my $workSheets;
	push(@{$workSheets},$workBook->add_worksheet());
	
	#iterate file line by line then assing exeryfield to the xlsx file
	# maybe text::csv module would be better here.
	while (<TXTFILE>) {
		chomp;
		my @t = split("$del");
		
		die "Exceeded max no of rows in spreadsheet format limit=$rowmax now at $." 
			if($rowmax < $.);
		
		my $col = 0;
		for my $token (@t) {
			if(not(floor($col/$colmax) < scalar(@{$workSheets}) )){
				push(@{$workSheets},$workBook->add_worksheet());
			}
			if($writestring != 0){
				$workSheets -> [floor($col/$colmax)] -> write_string(($.-1), $col%$colmax, $token);
			}else{
				$workSheets -> [floor($col/$colmax)] -> write(($.-1), $col%$colmax, $token);
			}
			$col++;
		}
	}
	close(TXTFILE);
	#Without this line below corrupt xlsx files are produced
	$workBook->close();
}


=head1 AUTHOR

mmterpstra, C<< <mmterpstra at github.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-tabletoxlsx at rt.cpan.org>, or through
the web interface at L<https://github.com/mmterpstra/TableToXlsx/issues>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc TableToXlsx


You can also look for information at:

=over 4

=item * github.com

L<https://github.com/mmterpstra/TableToXlsx>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 mmterpstra.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see L<http://www.gnu.org/licenses/>.


=cut

1; # End of TableToXlsx
