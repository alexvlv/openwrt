#!/usr/bin/env bash

# $Id$

export LANG=C
export LC_ALL=C
[ -n "$TOPDIR" ] && cd $TOPDIR

GIT_CWD=$1

try_git() {
	[ -n "GIT_CWD" ] || GIT_CWD="."
	git -C "$GIT_CWD" rev-parse --git-dir >/dev/null 2>&1 || return 1
        STR=$(git -C "$GIT_CWD" remote -v | grep origin | head -n1 | cut -f 2 | cut -d ' ' -f1 2>/dev/null)
	[ -n "STR" ]
}

try_git || STR=""
echo "$STR"
