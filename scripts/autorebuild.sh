#!/usr/bin/env bash

# $Id$

if [ -n "$TOPDIR" ]; then
	cd $TOPDIR
else
	TOPDIR="."
fi
BUILDDIR="$TOPDIR/build_dir"

disable() {
	[ -d "$PKGSDIR" ] || exit 1
	echo "Enable autorebuild in $PKGSDIR ..."
	for subdir in $PKGSDIR/*; do
		[ -d "$subdir" ] || continue
		name=$(basename $subdir)
		[ -z "${name##linux*}" ] && {
			echo "skip $subdir"
			continue
		}
		touch "$subdir/.no_autorebuild"
	done
	echo "Done!"
}

enable() {
	[ -d "$PKGSDIR" ] || exit 1
	echo "Disable autorebuild in $PKGSDIR ..."
	for subdir in $PKGSDIR/*; do
		[ -d "$subdir" ] || continue
		rm -f "$subdir/.no_autorebuild"
	done
	echo "Done!"
}

[ -n "$BUILDDIR" ] || exit 0
[ "$#" -ge 1 ] || exit 1

COMMAND="$1";
ARGT="$2";

case "$ARGT" in
	target) TARGET="target-mips_24kc_musl";;
	host) TARGET="host";;
	hostpkg) TARGET="hostpkg";;
	target) TARGET="target-mips_24kc_musl";;
	tool*) TARGET="toolchain-mips_2~_gcc-7.3.0_musl";;
	*) TARGET="target-mips_24kc_musl";;
esac

PKGSDIR="$BUILDDIR/$TARGET"

case "$COMMAND" in
	en*) enable;;
	di*) disable;;
esac
