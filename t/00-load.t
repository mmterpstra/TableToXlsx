#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'TableToXlsx' ) || print "Bail out!\n";
}

diag( "Testing TableToXlsx $TableToXlsx::VERSION, Perl $], $^X" );
