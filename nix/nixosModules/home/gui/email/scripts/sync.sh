#!/usr/bin/env bash

set -e

# flush deletes to local maildirs
notmuch search --format=text0 --output=files tag:killed | xargs -0 --no-run-if-empty rm

# synchronise local maildirs with remote servers
mbsync -all --pull --push

# synchronise local maildirs with notmuch and tag new mail
notmuch new

# synchronise local tags with remote servers
mbsync -all --push --flags
