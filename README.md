[![Build Status](https://travis-ci.org/mmterpstra/TableToXlsx.svg?branch=master)](https://travis-ci.org/mmterpstra/TableToXlsx)

# Summary / main notes

Convert your text based tables to excel format / Minimal example of the Excel::Writer::XLSX module in perl.
Some tables are best advised to be inspected in R but sometimes the user has more experience with spreadsheets. So for user friendlyness i made an automatic conversion tool to a spreadsheet friendly format using the 'Excel-Writer-XLSX-0.77' module / perl-v5.10.0. Although I've not tested it should be forward compatible.
The tableToXlsxAsStrings.pl should be mainly be used to convert genename tables to xlsx tables and for conversion of comma separated integer subfields. For incompatibilities with the dutch locale -> don't use the locale!

# Requirements

perl v5.10.0. Main goal: get 'Excel-Writer-XLSX-0.77' working. The rest are missing dependancies (of perl 5.10.0) in newer versions of perl most of them come preinstalled.
Archive-Zip-1.37
Excel-Writer-XLSX-0.77
File-Path-2.09
File-Temp-0.2304
parent-0.228

# Installing on Ubuntu

Code below because copy paste installs are the best
```
#1. install Excel::Writer::XLSX perl module 
sudo apt install libexcel-writer-xlsx-perl
#2. Dowload git repo and add location to path
wget https://github.com/mmterpstra/TableToXlsx/archive/master.zip
unzip https://github.com/mmterpstra/TableToXlsx/archive/master.zip
export PATH="$PATH:${PWD}/TableToXlsx-master/"
```
perm install
```
echo '#table to xlsx conversion' >>~/.bashrc
echo 'export PATH="$PATH:${PWD}/TableToXlsx-master/"' >>~/.bashrc
```

# Use

```
perl ${TABTOXLSX_HOME}tableToXlsxAsStrings.pl DELIM FILE
DELIM	Tekst delimiter use for splitting lines. Doesn't handle quotes.
FILE	File that is delimited with DELIM
output in FILE.xlsx
```

# Examples

This both examples will generate file.tsv.xlsx the second will overwrite the first.

```
perl ${TABTOXLSX_HOME}tableToXlsxAsStrings.pl \\t file.tsv
perl ${TABTOXLSX_HOME}tableToXlsx.pl \\t file.tsv
```

---
# Script functions
tableToXlsx.pl:
When you directly open something in excel this is what happens, or at least it will try to emulate the default behavior. This will be greedy toward interpreting everything as dates and as numbers. See also 'tableToXlsxAsStrings.pl' below

tableToXlsxAsStrings.pl:
This shows how to 'safely' convert a table to XLSX format. It does not try to interpret the data. This is safe when you have gene names or for example dots or comma's in numbers as a field separator. The separators for thousands/decimal numbers are not converted to local excel. The tableToXlsxAsStrings.pl should be mainly be used to convert genename tables to xlsx tables and for conversion of comma separated integers. For incompatibilities with the dutch locale -> don't use it!


