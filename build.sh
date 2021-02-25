#!/bin/sh

# $Id$

mkdir -p logs

BUILD_START=$(date +"%d/%m/%Y %H:%M")
echo "Build start at $BUILD_START"  | tee logs/build.log 
ionice -c 3 nice -n19 make -j$(($(nproc)+1)) V=s 2>&1 | tee -a logs/build.log
BUILD_END=$(date +"%d/%m/%Y %H:%M")
echo
cat ./firmware/banner
cat ./firmware/firmware.txt
echo
echo "Build start at $BUILD_START" | tee -a logs/build.log
echo "Build done  at $BUILD_END" | tee -a logs/build.log
