#!perl

use strict;
use warnings;

use Capture::Tiny qw(capture);
use Config;
use Test::More tests => 3;

my $perl        = $Config{perlpath};
my @wp_tools    = ($perl, 'script/wp-tools');

{
    my ($out, $err) = capture { system(@wp_tools, '--version') };
    my $exit_status = $? >> 8;
    is($exit_status, 0, '--version flag works') or diag($out, $err);
    like($out, qr/version \d/, '--version prints a version');
}

{
    my ($out, $err) = capture { system(@wp_tools, '--help') };
    my $exit_status = $? >> 8;
    is($exit_status, 0, '--help flag works') or diag($out, $err);
}

