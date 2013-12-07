#!/bin/sh
# push-to-remotes: Git (post-receive) hook to push/clone changes to remotes
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
# * Copy or symlink this script to hooks/post-receive in the repository
#

BRANCH='refs/heads/master'

echo '';
echo 'push-to-remotes Copyright 2013 Sudaraka Wijesinghe';
echo 'This program comes with ABSOLUTELY NO WARRANTY;';
echo 'This is free software, and you are welcome to redistribute it';
echo 'under certain conditions under GNU GPLv3 or later.';
echo '';

while read OLDREV NEWREV REFNAME;
do
    if [ "$REFNAME" = "$BRANCH" ]; then
        for remote in `git remote`; do
            echo "PUSHING TO: $remote";

            git push $remote $REFNAME:$BRANCH;

            echo '';
        done;
    fi;
done;

exit 0;
