perl -we 'print "sheet1". "\t" x 1024 . "sheet2"' >  test.tsv
perl tableToXlsxAsStrings.pl \\t test.tsv
perl tableToXlsx.pl \\t test.tsv
perl -we 'print "X\n" x 1048576' >  test.tsv
perl tableToXlsxAsStrings.pl \\t test.tsv
perl tableToXlsx.pl \\t test.tsv


