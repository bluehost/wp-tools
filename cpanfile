
requires 'Digest::MD5';
requires 'Fcntl';
requires 'File::Find';
requires 'File::Path';
requires 'File::Slurper';
requires 'Getopt::Long';
requires 'HTTP::Tiny';
requires 'String::ShellQuote';
requires 'sigtrap';

# Support testing WordPress sites over HTTPS:
recommends 'IO::Socket::SSL', '1.56';
recommends 'Net::SSLeay', '1.49';

on test => sub {
    requires 'Capture::Tiny';
    requires 'Test::More';
};

