#!perl

use strict;
use warnings;

use Capture::Tiny qw(capture);
use Config;
use Test::More tests => 2;

my $perl = $Config{perlpath};

BEGIN {
    use_ok('App::WordPressTools', 'the main module can be used');
}

my ($out, $err) = capture { system($perl, qw{-c script/wp-tools}) };
my $exit_status = $? >> 8;
is($exit_status, 0, 'wp-tools compiles') or diag($out, $err);

