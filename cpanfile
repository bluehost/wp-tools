
requires 'Digest::SHA';
requires 'Fcntl';
requires 'File::Find';
requires 'File::Path';
requires 'File::Slurp';
requires 'Getopt::Long';
requires 'LWP::UserAgent';
requires 'String::ShellQuote';
requires 'sigtrap';

on test => sub {
    requires 'Test::More';
};

