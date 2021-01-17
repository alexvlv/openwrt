#!/bin/sh

# $Id$

[ -n "$TOPDIR" ] || export TOPDIR=${PWD}
TARGET="$1"
[ -n "$TARGET" ] || TARGET="ar71xx"

export PATH=${TOPDIR}/staging_dir/host/bin:${PATH}

LOGDIR=${TOPDIR}/logs
LOGFILE=${LOGDIR}/image.log
MAKEDIR=${TOPDIR}/target/linux/${TARGET}/image

[ -d "${MAKEDIR}" ] || exit 1

mkdir -p ${LOGDIR}
BUILD_START=$(date +"%d/%m/%Y %H:%M")
echo "Build [${TARGET}] start at ${BUILD_START}"  | tee ${LOGFILE}
make  -C ${MAKEDIR} install V=s 2>&1 | tee -a ${LOGFILE}
BUILD_END=$(date +"%d/%m/%Y %H:%M")
echo "Build [${TARGET}] start at ${BUILD_START}" | tee -a ${LOGFILE}
echo "Build [${TARGET}] done  at ${BUILD_END}" | tee -a ${LOGFILE}
