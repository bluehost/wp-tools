# NAME

App::WordPressTools::Contributing - How to contribute to wp-tools

# GETTING INVOLVED

If you'd like to contribute a patch to improve the [wp-tools](https://metacpan.org/pod/wp-tools) documentation or tests, fix a bug, or add a new feature,
we think that's great. Here's how to do it:

## Get the Code

1. Clone the repository.

    If you use GitHub, fork wp-tools and then clone your fork:

        git clone git@github.com:$GITHUB_USERNAME/wp-tools.git

    If you don't use GitHub, you can clone the official repository:

        git clone https://github.com/bluehost/wp-tools.git

2. Install [Dist::Zilla](https://metacpan.org/pod/Dist%3A%3AZilla).

        cpanm Dist::Zilla

3. Install the Perl dependencies using Dist::Zilla:

        dzil authordeps --missing | cpanm
        dzil listdeps --author --develop --missing | cpanm

4. Make sure the tests pass:

        dzil test

## Repository Structure

- lib

    Contains source code and source documentation in the form of Perl modules and POD files.

- script

    Contains executable source code.

- t

    Contains test scripts.

- maint

    Contains release management scripts.

- CONTRIBUTING.md, LICENSE, README.md

    Rendered documentation. Do **NOT** modify these files directly because their contents are built from other files. You may
    commit changes to these files as long as their source files were updated.

- Changes

    Lists releases and associated changes.

## Branch Layout

- master

    This is the shared development branch. It may contain accepted but unreleased commits, but it does not include anything
    that is known to be broken or a WIP -- that's what topics are for. Topics should be branched from master.

- release

    The release branch tracks master but lags behind. The tip of this branch always points to the latest release commit, so
    this branch is the **stable** branch.

- topic/\*

    Topics are branched from master and may contain experimental and broken code. They are for work in progress. Topics may
    be rebased and cleaned up for eventual merging back into master. Topics may be namespaced "topic/" or not.

- dist

    The dist branch includes releases built for distribution to the CPAN. This branch shares no commits with any other
    branch and is maintained by release management scripts.

- solo

    The solo branch includes releases built as standalone scripts (for curl installation). This branch shares no commits
    with any other branch and is maintained by release management scripts.

## Commit Guidelines

In general, follow the [Commit Guidelines](https://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project#Commit-Guidelines)
from the [Pro Git](https://git-scm.com/book/en/v2) book. In particular:

- Clean up your branch.

    Remember that your topic branch is yours. You can and should rewrite its history so that its history is clean and
    straightforward without any "fixup" commits. These commands can help you clean up your history:

        git commit --amend
        git rebase --interactive
        git cherry-pick

- Follow the same code style already used in the file(s) you're editing.
- Fix whitespace errors.

    Use `git diff --check` to get a list of potential whitespace errors.

- Rebase on the latest master.

    In order to make sure your topic will merge back with master without conflicts, rebase your topic onto the tip of
    master. If there are conflicts, resolve them.

        git checkout $TOPIC_BRANCH
        git pull --rebase origin master

- Add documentation for new features.
- Add tests.
- Write good commit messages.

    The commit message "subject" is on the first line and should be 50 characters or less. If the commit needs more
    explanation, the commit message "body" then comes after an empty line and is wrapped to about 72 characters.

## Development Workflow

Before you start, you may want to read and make sure you understand the ["Commit Guidelines"](#commit-guidelines), ["Directory Structure"](#directory-structure),
and ["Branch Layout"](#branch-layout).

1. Branch your topic from master:

        git checkout -b $TOPIC_BRANCH master

2. Make your changes in a logical sequence of one or more commits.

    See ["Commit Guidelines"](#commit-guidelines).

3. Make sure the tests still pass:

        dzil test

4. Send your patches to the authors.

    If you use GitHub, you can push your topic branch to your fork and then create a pull request back to our master branch
    using the GitHub interface:

        git push origin $TOPIC_BRANCH

    If you don't use GitHub, send your patch to the authors via email:

        git checkout $TOPIC_BRANCH
        git format-patch -M origin

        # Then send patches as attachments using your favorite email client or using git:
        git send-email *.patch

    See [Public Project over Email](https://git-scm.com/book/en/v2/Distributed-Git-Contributing-to-a-Project#Public-Project-over-Email)
    from the [Pro Git](https://git-scm.com/book/en/v2) book for instructions on configuring git for sending email.

## Release Workflow

We use [Dist::Zilla](https://metacpan.org/pod/Dist%3A%3AZilla) to manage releases. The release management scripts do pretty much all of the work.

1. Write to the changelog.

    First, take a look at the list of commits since the last release:

        git shortlog origin/release..master

    Then edit `Changes` and summarize the changes after the `{{$NEXT}}` token. Just leave the file uncommitted; it will
    automatically be committed in the next step.

2. Run the release script and follow the prompts:

        git checkout master
        dzil release

    The release script will take care of making the release commit (with `Changes`), tagging, and uploading to the CPAN.
