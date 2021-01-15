#!/bin/sh

# $Id$

BUILD_START=$(date +"%d/%m/%Y %H:%M")
echo "Build start at $BUILD_START"  | tee build.log 
ionice -c 3 nice -n19 make -j$(($(nproc)+1)) V=s 2>&1 | tee -a build.log 
BUILD_END=$(date +"%d/%m/%Y %H:%M")
echo "Build start at $BUILD_START" | tee -a build.log 
echo "Build done  at $BUILD_END" | tee -a build.log 
