#!/bin/sh

# $Id$

[ -n "$TOPDIR" ] || export TOPDIR=${PWD}
TARGET="$1"
[ -n "$TARGET" ] || TARGET="uImage"

TFTDIR="/work/srv/tftp/caramb"

export STAGING_DIR=${TOPDIR}/staging_dir
export CROSS_COMPILE=${STAGING_DIR}/toolchain-mips_24kc_gcc-7.3.0_musl/bin/mips-openwrt-linux-musl-
export ARCH=mips

export PATH=${PATH}:${TOPDIR}/staging_dir/host/bin

LOGDIR=${TOPDIR}/logs
LOGFILE=${LOGDIR}/kernel-${TARGET}.log
MAKEDIR=${TOPDIR}/build_dir/target-mips_24kc_musl/linux-ar71xx_generic/linux-4.9.243/

UIMAGE=${MAKEDIR}/arch/mips/boot/uImage.bin

[ -d "${MAKEDIR}" ] || exit 1

mkdir -p ${LOGDIR}
BUILD_START=$(date +"%d/%m/%Y %H:%M")
echo "Build [${TARGET}] start at ${BUILD_START}"  | tee ${LOGFILE}
make  -C ${MAKEDIR} $@ V=s 2>&1 | tee -a ${LOGFILE}
ln -s -f ${MAKEDIR}/arch/mips/boot/uImage.bin ${TFTDIR}/uImage.bin
[ "$TARGET" = "uImage" ]  && [ -s "$UIMAGE" ] && ln -s -f ${UIMAGE} ${TFTDIR}/uImage.bin
BUILD_END=$(date +"%d/%m/%Y %H:%M")
echo "Build [${TARGET}] start at ${BUILD_START}" | tee -a ${LOGFILE}
echo "Build [${TARGET}] done  at ${BUILD_END}" | tee -a ${LOGFILE}
