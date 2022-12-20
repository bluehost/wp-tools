# NAME

wp-tools - tools to backup and upgrade WordPress installations

# SYNOPSIS

    # simple installation from CPAN
    cpanm App::WordPressTools

    # view usage information
    wp-tools --help

    # common usage
    wp-tools upgrade|backup|restore OPTIONS...

# DESCRIPTION

**DEPRECATED** - WordPress Tools has been used to upgrade millions of websites, but there are now better tools available
and so we no longer maintain WordPress Tools. You can use [WP-CLI](http://wp-cli.org/) directly for keeping your
websites up-to-date, and look for a [backup plugin](https://wordpress.org/plugins/search/backup/) to manage your
backups.

WordPress Tools is a set of tools that allow you to backup, restore, and upgrade WordPress sites. The tools are
especially useful for upgrading very outdated sites and for scripting the backing up and upgrading of **many** sites.

WordPress Tools was built to make the Internet more secure. A huge number of websites on the Internet use
[WordPress](https://wordpress.org/), because it's awesome, but a large portion of those sites do not run the latest
version of WordPress which makes them susceptible to hacking. WordPress Tools can be used to get those sites up-to-date
again, and that makes the whole Internet more secure.

The code has been used in production and has already upgraded over two million WordPress sites, but it has little
real-world testing outside of Linux at this point so your mileage may vary if you have a different operating system.
Stay tuned as we add support for more platforms, and please contribute if you feel like it.

The command-line program also has a lot of options for managing server load, so you can upgrade your sites without
killing your server.

# INSTALLATION

There are several ways to install WordPress Tools to your system.

Make sure you have [WP-CLI](http://wp-cli.org/) and the other ["DEPENDENCIES"](#dependencies) installed.

## Using cpanm

You can install WordPress Tools using [cpanm](https://metacpan.org/pod/cpanm). If you have a local perl (plenv, perlbrew, etc.), you can just do:

    cpanm App::WordPressTools

to install the `wp-tools` executable and its dependencies. The executable will be installed to your perl's bin path,
like `~/perl5/perlbrew/bin/wp-tools`.

If you're installing to your system perl, you can do:

    cpanm --sudo App::WordPressTools

to install the `wp-tools` executable to a system directory, like `/usr/local/bin/wp-tools` (depending on your perl).

## Downloading just the executable

You may also choose to download `wp-tools` as a single executable, like this:

    curl -OL https://raw.githubusercontent.com/bluehost/wp-tools/solo/wp-tools
    chmod +x wp-tools

This executable includes all the non-core Perl module dependencies built-in.

## For developers

If you're a developer and want to hack on the source, clone the repository and pull the dependencies:

    git clone https://github.com/bluehost/wp-tools.git
    cd wp-tools
    cpanm -n Dist::Zilla
    dzil authordeps --missing |cpanm -n
    dzil listdeps --author --develop --missing |cpanm -n

# DEPENDENCIES

WordPress Tools requires these other programs and libraries in order to do its work. You probably have most of these on
your system already, and the cpanm method of installing wp-tools will handle the Perl module dependencies for you.

- [WP-CLI](http://wp-cli.org/)
- [GNU Coreutils](https://www.gnu.org/software/coreutils/)
- [GNU Tar](https://www.gnu.org/software/tar/)
- awk
- grep
- mysql (MySQL server client)
- procps
- Various Perl modules (see the distributed `cpanfile` file for a list)

# OPTIONS

- --help

    Show usage information and exit.

- --force

    If there are any resource limits in effect, ignore them and do the command anyway.

- --max-count=num

    Delete the oldest backups, keeping the number provided (default: 5).

- --max-dproc=num

    Refuse to execute if the maximum number of defunct processes on the system exceeds this number (default: 100).

- --max-load=num

    Refuse to execute if the load average exceeds this number (default: 200).

- --max-size=num

    Refuse to back up a site if its uncompressed size on disk exceeds this number of bytes (default: 5368709120).

- --max-run=num

    Do not allow more than this number of concurrent system-wide executions of the script (default: 50).

- --min-freemem=num

    Refuse to execute if free memory has dropped below this number of bytes (default: 1048576).

- --wp-cli=path

    If your `wp-cli` program has a different name than `wp` or is not in your `$PATH`, you can specify the command to be
    used to call wp-cli.

- --username=name

    If you run wp-tools as a root user, it will drop permissions to the specified user and `chdir` to their home directory.

# COMMANDS

- upgrade

    The upgrade command will upgrade your WordPress core, themes, and plugins to the latest version available. It takes
    a full backup prior to the update. After the update, wp-tools will do a quick check to try to determine that nothing
    broke on your site. If any failures are detected, wp-tools will automatically restore to the backup taken prior to
    update.

- backup

    The backup command will create a full backup, including database, of your WordPress installation as long as it is under
    the --max-size limit (pre-compression).

- restore

    The restore command will restore a WordPress installation from a backup taken using the backup command.

# EXAMPLES

    # upgrade a site
    wp-tools upgrade --path=/absolute/path/to/public_html/myblog \
                     --backupdir=/absolute/path/to/myblog_backups

    # upgrade only plugins and themes
    wp-tools upgrade --path=/absolute/path/to/public_html/myblog  \
                     --backupdir=/absolute/path/to/myblog_backups \
                     --components=plugin,theme

    # backup a site
    wp-tools backup --path=/absolute/path/to/public_html/mysite \
                    --backupdir=/absolute/path/to/backups/mysite

    # restore a site to a previous state
    wp-tools restore --backupfile=/absolute/path/to/backups/mysite/wp_backup1428524082.tar.gz

# NOTES

Beginning with version 1.03, passing relative paths to `--path`, `--backupdir`, and `--backupfile` is **deprecated**.
You should use absolute paths (i.e. that begin with a `/`). Relative paths are accepted but will print a warning to
`STDERR`. This is because using a relative path does not behave as you would think (for boring historical reasons).

# CONTRIBUTORS

Many people were involved in the creation of WordPress Tools. In particular:

- Matt Andersen
- Gabriel Peery

# AUTHORS

- Seth Johnson <sj@bluehost.com>
- Charles McGarvey <cmcgarvey@bluehost.com>
- Garth Mortensen <gmortensen@bluehost.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016-2018 by Bluehost Inc.

This is free software, licensed under:

The GNU General Public License, Version 2, June 1991
