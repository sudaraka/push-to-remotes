#!/bin/sh
# fetch-from-github.sh: Git (pre-receive) hook to fetch changes to Github
#
#   Copyright 2013 Sudaraka Wijesinghe <sudaraka.org/contact>
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# Requirements:
# -------------
# * Remote named 'github' configured in the receiving repository
# * Copy or symlink this script to hooks/pre-receive in the repository
#

REMOTE='github';
BRANCH='master';
BRANCH_REF="refs/heads/$BRANCH";

echo '';
echo 'fetch-from-github Copyright 2013 Sudaraka Wijesinghe';
echo 'This program comes with ABSOLUTELY NO WARRANTY;';
echo 'This is free software, and you are welcome to redistribute it';
echo 'under certain conditions under GNU GPLv3 or later.';
echo '';

if [ ! -z `git remote|grep "$REMOTE"` ]; then
    echo "FETCHING FROM: $REMOTE";

    if [ -z `git branch -r |grep $REMOTE|grep $BRANCH` ]; then
        # When there is no reference to remote branch, it is assumed the remote
        # repository is empty and will not attempt to fetch. Operation will
        # continue as successful.
        exit 0;
    fi;

    while read OLDREV NEWREV REFNAME;
    do
        if [ "$REFNAME" = "$BRANCH_REF" ]; then
            exec git fetch  $REMOTE $REFNAME:$BRANCH_REF;
            if [ 0 -ne $? ]; then
                exit 1;
            fi;
        fi;
    done;
else
    echo "$REMOTE not found.";
    exit 1;
fi;

exit 0;
