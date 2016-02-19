#!/usr/bin/env perl

# This script creates a separate tree and branch for just the dist.

use strict;
use warnings;
use autodie;

use File::Copy;
use File::Path qw(make_path remove_tree);
use String::ShellQuote;


my $version = shift or die 'Need version';
my $distdir = shift or die 'Need distdir';

my $branch_name = 'dist';

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

system(qw{git add -f}, $distdir);
my $tree_ref = `git write-tree --prefix=$distdir/`;
chomp $tree_ref;

system(qw{git reset}, $distdir);

my $branch_oldref_safe = shell_quote($branch_oldref);
my $tree_ref_safe = shell_quote($tree_ref);
my $parent = $branch_oldref ? "-p $branch_oldref_safe" : '';
my $commit_ref = `git commit-tree -m $commit_msg $parent $tree_ref_safe`;
chomp $commit_ref;

system(qw(git branch -f), $branch_name, $commit_ref);
system(qw(git tag -a -m), "Version $version", "$branch_name-$version", $commit_ref);

