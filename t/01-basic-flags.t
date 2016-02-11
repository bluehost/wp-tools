#!perl

use strict;
use warnings;

use Test::More tests => 2;

my @wp_tools = qw(blib/script/wp-tools);
@wp_tools = qw(perl script/wp-tools) if !-x $wp_tools[0];

is(system(@wp_tools, '--version'),  0, '--version flag works');
is(system(@wp_tools, '--help'),     0, '--help flag works');

