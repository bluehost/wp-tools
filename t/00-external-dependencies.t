#!perl

use strict;
use warnings;

use Capture::Tiny qw(capture);
use Test::More tests => 3;

isnt($^O, 'MSWin32', 'OS is not Windows') or BAIL_OUT('OS unsupported');

{
    my ($out, $err) = capture { system(qw(tar --version)) };
    my $exit_status = $? >> 8;
    my $t1 = is($exit_status, 0, 'can run tar');
    my $t2 = like($out, qr/GNU tar/, 'tar is GNU tar');
    BAIL_OUT('OS unsupported') if !$t1 || !$t2;
}

