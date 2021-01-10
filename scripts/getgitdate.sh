#!/usr/bin/env bash

# $Id$

export LANG=C
export LC_ALL=C
[ -n "$TOPDIR" ] && cd $TOPDIR

GIT_CWD=$1

try_git() {
	[ -n "GIT_CWD" ] || GIT_CWD="."
	git -C "$GIT_CWD" rev-parse --git-dir >/dev/null 2>&1 || return 1
        DATE=$(git -C "$GIT_CWD" log -n 1 --format="%cd" --date="format:%Y-%m-%d %H:%M:%S" 2>/dev/null)
	[ -n "DATE" ]
}

try_git || DATE=""
echo -n "$DATE"
