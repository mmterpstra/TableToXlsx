use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

my @exe_files = glob("src/*.pl");


WriteMakefile(
	NAME             => 'TableToXlsx',
	AUTHOR           => q{mmterpstra <mmterpstra@github.com>},
	VERSION_FROM     => 'lib/TableToXlsx.pm',
	ABSTRACT_FROM    => 'lib/TableToXlsx.pm',
	LICENSE          => 'gpl_3',
	PL_FILES         => {},
	MIN_PERL_VERSION => 5.006,
	CONFIGURE_REQUIRES => {
		'ExtUtils::MakeMaker' => 0,
	},
	BUILD_REQUIRES => {
		'Test::More' => 0,
	},
	PREREQ_PM => {
		'Excel::Writer::XLSX'              => 0.86,
		#'Foo::Bar::Module' => 5.0401,
	},
	"EXE_FILES" => [@exe_files],
	dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
	clean => { FILES => 'TableToXlsx-*' },
);
