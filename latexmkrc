#!/usr/bin/env perl

# Default behavior: 4 = LuaLaTeX, 3 = upLaTeX
$pdf_mode     = 4;
$max_repeat   = 5;

# LuaLaTeX (-pdflua or pdf_mode=4)
$lualatex     = 'lualatex -synctex=1 -file-line-error -interaction=nonstopmode %O %S';
# pdflatex (-pdf or pdf_mode=1)
$pdflatex     = 'pdflatex -synctex=1 -file-line-error -interaction=nonstopmode %O %S';
# upLaTeX  (-pdfdvi or pdf_mode=3)
$latex        = 'uplatex -synctex=1 -file-line-error -interaction=nonstopmode %O %S';
$dvipdf       = 'dvipdfmx %O -o %D %S';
# common tools
$biber        = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex       = 'upbibtex %O %B';
$makeindex    = 'upmendex %O -o %D %S';

my $build_dir = 'build';

use File::Path qw(make_path);
make_path($build_dir) unless -d $build_dir;

$out_dir = $build_dir;
$aux_dir = $build_dir;

$clean_ext .= " %R.*-SAVE-ERROR";