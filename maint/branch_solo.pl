#!/usr/bin/env perl

# This script prepares the wp-tools script for standalone use and puts it in a new branch.

use strict;
use warnings;
use autodie;

use File::Copy;
use File::Path qw(make_path remove_tree);
use String::ShellQuote;


my $version = shift or die 'Need version';
my $distdir = shift or die 'Need distdir';

my $branch_name = 'solo';

my $branch_oldref = '';
my $branch_oldref_origin = '';

open(my $fh, '-|', qw{git show-ref}, $branch_name);
while (my $line = <$fh>) {
    chomp $line;
    my ($hash, $ref) = split(/\s+/, $line);
    $branch_oldref = $hash          if $ref eq "refs/heads/$branch_name";
    $branch_oldref_origin = $hash   if $ref eq "refs/remotes/origin/$branch_name";
}
if ($branch_oldref_origin && $branch_oldref ne $branch_oldref_origin) {
    # reset local branch
    system(qw{git branch -f}, $branch_name, "origin/$branch_name");
    $branch_oldref = $branch_oldref_origin
}

my $commit_msg = shell_quote("Release $version");

my $solodir = "solo_branch.$$";
make_path($solodir);

open(my $in,  '<', "$distdir/script/wp-tools");
open(my $out, '>', "$solodir/wp-tools");
while (my $line = <$in>) {
    $line = "#!/usr/bin/env perl\n" if $line =~ /^#!perl/;
    $line = '' if $line =~ /^use App::WordPressTools;/;
    $line = "our \$VERSION = '$version';\n" if $line =~ /^our \$VERSION = /;
    print $out $line;
}
chmod(0755, "$solodir/wp-tools");
copy("$distdir/README", "$solodir/README");
copy("$distdir/CONTRIBUTING", "$solodir/CONTRIBUTING");

system(qw{git update-index --add}, glob("$solodir/*"));
my $tree_ref = `git write-tree --prefix=$solodir/`;
chomp $tree_ref;

system(qw{git reset});
remove_tree($solodir);

my $branch_oldref_safe = shell_quote($branch_oldref);
my $tree_ref_safe = shell_quote($tree_ref);
my $parent = $branch_oldref ? "-p $branch_oldref_safe" : '';
my $commit_ref = `git commit-tree -m $commit_msg $parent $tree_ref_safe`;
chomp $commit_ref;

system(qw(git branch -f), $branch_name, $commit_ref);
system(qw(git tag -a -m), "Version $version", "$branch_name-$version", $commit_ref);

