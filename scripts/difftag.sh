#!/bin/sh

# $Id$

[ -d .git ] || return 1

TAG="v18.06.9"
DIR="../$TAG-diff"

mkdir -p $DIR/changed
rm -rf $DIR/changed/

git diff $TAG > $DIR/$TAG.patch
git diff $TAG --name-only > $DIR/changed.txt
cat $DIR/changed.txt | cpio -pdm  $DIR/changed
tar -cvzf $DIR/$TAG.tgz -T $DIR/changed.txt