#!/usr/bin/env bash

# $Id$

export LANG=C
export LC_ALL=C
[ -n "$TOPDIR" ] && cd $TOPDIR

GIT_CWD=$1

try_git() {
	[ -n "GIT_CWD" ] || GIT_CWD="."
	git -C "$GIT_CWD" rev-parse --git-dir >/dev/null 2>&1 || return 1
        BRANCH=$(git -C "$GIT_CWD"  rev-parse --abbrev-ref HEAD 2>/dev/null)
	[ -n "BRANCH" ]
}

try_git || BRANCH="Unknown"
echo -n "$BRANCH"
