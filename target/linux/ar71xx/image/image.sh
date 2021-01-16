#!/bin/sh

# $Id$

export TOPDIR=/work/projects/OpenWrt/OpenWrt-18.06.9/git
export PATH=$TOPDIR/staging_dir/host/bin:$PATH

LOGDIR=${TOPDIR}/logs
LOGFILE=${LOGDIR}/image.log
MAKEDIR=target/linux/ar71xx/image

mkdir -p ${LOGDIR}
BUILD_START=$(date +"%d/%m/%Y %H:%M")
echo "Build start at ${BUILD_START}"  | tee ${LOGFILE}
make  -C ${MAKEDIR} install V=s 2>&1 | tee -a ${LOGFILE}
BUILD_END=$(date +"%d/%m/%Y %H:%M")
echo "Build start at ${BUILD_START}" | tee -a ${LOGFILE}
echo "Build done  at ${BUILD_END}" | tee -a ${LOGFILE}
