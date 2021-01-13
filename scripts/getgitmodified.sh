#!/usr/bin/env bash

# $Id$

export LANG=C
export LC_ALL=C
[ -n "$TOPDIR" ] && cd $TOPDIR

GIT_CWD=$1

try_git() {
	[ -n "GIT_CWD" ] || GIT_CWD="."
	git -C "$GIT_CWD" rev-parse --git-dir >/dev/null 2>&1 || return 1
	STR=$(git -C "$GIT_CWD" status --porcelain 2>/dev/null)
	[ -n "$STR" ] && STR="*"
}

try_git
echo "$STR"
