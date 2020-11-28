#!/bin/sh

set -e

# "already mounted" is also an error
gio mount ftps://rustdoc.etonomy.org/ || true
# check for actual success of the above
gio list ftps://rustdoc.etonomy.org/ >/dev/null

[ -e /run/user/1000/gvfs/ftps:host=rustdoc.etonomy.org ]

# Given we can't set time stamps on this server, and checksumming would mean
# getting the whole file, we trust that any changes are reflected in size changes
#
# Doing riot_wrappers first because those are the most active and provide
# quickly checkable results as opposed to the possibly slow tail
rsync -vr --ignore-times --perms ./target/i686-unknown-linux-gnu/doc/riot_wrappers /run/user/1000/gvfs/ftps:host=rustdoc.etonomy.org/
rsync -vr --ignore-times --perms ./target/i686-unknown-linux-gnu/doc/riot_* /run/user/1000/gvfs/ftps:host=rustdoc.etonomy.org/
