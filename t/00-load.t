#!perl

use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
    use_ok('App::WordPressTools', 'the main module can be used');
}

`perl -c script/wp-tools 2>/dev/null`;
my $exit_status = $? >> 8;
is($exit_status, 0, 'wp-tools compiles');

