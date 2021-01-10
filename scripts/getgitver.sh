#!/usr/bin/env bash

# $Id$

export LANG=C
export LC_ALL=C
[ -n "$TOPDIR" ] && cd $TOPDIR

GIT_CWD=$1

try_git() {
	[ -n "GIT_CWD" ] || GIT_CWD="."
	git -C "$GIT_CWD" rev-parse --git-dir >/dev/null 2>&1 || return 1
        CNT=$(git -C "$GIT_CWD" rev-list HEAD | wc -l | awk '{print $1}')
        let CNT=CNT-1
        HASH=$(git -C "$GIT_CWD" log -n 1 --format="%h")
        #DATE=$(git -C "$GIT_CWD" log -n 1 --format="%cd" --date="format:%Y-%m-%d %H:%M:%S")
        REV="r$CNT-$HASH"
	[ -n "$REV" ]
}

try_git || REV="unknown"
echo -n "$REV"
