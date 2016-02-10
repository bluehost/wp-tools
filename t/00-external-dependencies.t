#!perl

use strict;
use warnings;

use Test::More tests => 2;

my $tar_out = `tar --version`;
my $exit_status = $? >> 8;
is($exit_status, 0, 'can run tar');
ok($tar_out =~ /GNU tar/, 'tar is GNU tar');

