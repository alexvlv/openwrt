#!/bin/sh

# $Id: make.sh 389 2019-10-31 16:02:10Z alexvol $
# $HeadURL: http://server/svn/ARM-Linux/platforms/Carambola/OpenWrt-18.06.4/git/make.sh $
# $LastChangedRevision: 389 $
# $LastChangedDate: 2019-10-31 19:02:10 +0300 (Чт, 31 окт 2019) $
# $LastChangedBy: alexvol $

BUILD=$(date +%y%m%d-%H%M | tr -d "\n")
date  +%s > version.date

BANNER="build_dir/target-mips_24kc_musl/root-ar71xx/etc/banner"

. ./files/etc/device_info

export PRODUCT=${DEVICE_PRODUCT}
export URL=${DEVICE_MANUFACTURER_URL}
#export SVN=$(LC_ALL=C svn info ${URL} | grep "Rev:" | cut -b 19- | tr -d "\n")
export SVN=5957

echo "BUILD $DEVICE_PRODUCT SVN rev.$SVN $BUILD \n${URL}"

TEMPLATES="/etc/banner /etc/openwrt_release /etc/fstab"
for FP in $TEMPLATES; do
     TMPL=files/opt/share/templates$FP
     FILE=files$FP
    if [ -e $TMPL  ]; then
		sed -e "s/\${i}/1/" -e "s/\${BUILD}/$BUILD/" -e "s/\${PRODUCT}/$PRODUCT/"  -e "s/\${SVN}/$SVN/" $TMPL > $FILE
    fi
done

echo $SVN > files/svn

cat files/etc/banner

ionice -c 3 nice -n19 make -j2 V=s 2>&1 | tee build.log 

echo "Build done, install binaries..."

BINDIR=bin/targets/ar71xx/generic/

UIMAGE=openwrt-ar71xx-generic-uImage-lzma.bin
if [ -e $BINDIR/$UIMAGE ]; then
    staging_dir/host/bin/mkimage -l $BINDIR/$UIMAGE
fi

BINFILE=openwrt-ar71xx-generic-carambola2-squashfs-sysupgrade.bin
ROOTFS=openwrt-ar71xx-generic-root.squashfs

OUT_NAME=${PRODUCT}-${BUILD}
OUT_BIN=${OUT_NAME}-sysupgrade.bin
OUT_UIMAGE=${OUT_NAME}-uImage.bin
OUT_ROOTFS=${OUT_NAME}.squashfs
OUT_BANNER=${OUT_NAME}.txt
OUT_TAR=${OUT_NAME}-files.tgz

OUTDIR=bin_out/${PRODUCT}/${BUILD}

TFTP_DIR=/work/srv/tftp/caramb
NFS_DIR=/work/srv/nfs/${PRODUCT}/firmware

if [ -e $BINDIR/$BINFILE ]; then
    mkdir -p ${OUTDIR}
    mkdir -p $NFS_DIR
    mkdir -p $TFTP_DIR

    cp -f $BINDIR/$BINFILE $OUTDIR/$OUT_BIN
    ln -f -s -r $OUTDIR/$OUT_BIN $OUTDIR/firmware.bin

    cp -f $BINDIR/$UIMAGE  $OUTDIR/$OUT_UIMAGE
    cp -f $BINDIR/$ROOTFS  $OUTDIR/$OUT_ROOTFS
    cp -f $BINDIR/sha256sums  $OUTDIR/sha256sums

    cp -f $OUTDIR/$OUT_BIN $TFTP_DIR/
    ln -f -s -r $TFTP_DIR/$OUT_BIN $TFTP_DIR/firmware.bin
    cp -f $OUTDIR/$OUT_BIN $NFS_DIR/

	echo "Create tar archive..."
	tar cz -C files -f ${OUTDIR}/${OUT_TAR} .

	if [ -e $BANNER ]; then
		cat $BANNER
		cp -f $BANNER $OUTDIR/$OUT_BANNER
	fi
fi

echo Done, build:[$BUILD]
