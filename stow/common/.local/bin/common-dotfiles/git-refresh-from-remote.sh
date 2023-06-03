#!/bin/sh
#
# This script will update a subdirectory within a git checkout directory (aka
# the parent repository), which contains the contents of another git
# repository (aka the child repository). It will create a single commit to
# bring the parent's subdirectory up-to-date with the current contents of the
# child repository, with a commit comment which contains the short hash of the
# latest commit from the child (if there are no changes, a commit is not
# created).
#
# This script can therefore be considered as a lightweight way of
# representing, and keeping up-to-date, the contents of a child repository
# within a parent, without explicit use of git-submodule.
#
# The script tries to be "safe" by creating a stash first for any local
# changes in the parent repository, and restoring it at the end.
#
# Note that git history from the child repository is not accurately
# represented in the parent repository - commits from the child repo between
# the last time this command was called, and this one, are ignored, apart from
# the very latest.
#
# Example usage:
#
# git-refresh-from-remote ~/local-git-checkout/repositoryX http://remote.host/repositoryX
#
# Possible future enhancements:
#
# * Support --no-commit, like other git commands.
# * Support complete representation of child history in parent.
# * Clarify process/message printed when adding child repo for the first time.
# * Support stash list not being empty (currently doesn't work if one is never saved).

set -o errexit

if [ `git stash list | wc -l` -gt 0 ]; then
    echo "Cannot start git-refresh-from-remote as stash list is not empty."
    exit 1
fi

THROWAWAYCHANGESDIR=`mktemp -d -t grfr.throwawaychangesdir.XXXX`
MODULETEMPDIR=`mktemp -d -t grfr.moduletempdir.XXXX`

git clone --depth 1 $2 $MODULETEMPDIR
(cd $MODULETEMPDIR && git submodule update --init --recursive)
commit=`(cd $MODULETEMPDIR && git rev-parse --short HEAD)`
(cd $MODULETEMPDIR && find . | grep /.git$ | xargs rm -R)

git stash save -q --include-untracked "git-refresh-from-remote: temporary stash for updating $1."
echo "Moving $1 out of the way to $THROWAWAYCHANGESDIR"
(cd $1) && mv $1 $THROWAWAYCHANGESDIR/

mv $MODULETEMPDIR $1
git add -A $1 && git commit -m "Update $1 ($commit from $2)." || rc=$?
git stash pop -q
