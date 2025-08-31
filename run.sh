#!/bin/bash
set -ex

# Prepare the environment (assuming tools are already present or handled by workflow)
# sudo apt install git wget lz4 tar openssl python3 -y

# Fetch image from URL
RECOVERY_URL=${RECOVERY_URL:-$1}

if [ -z "$RECOVERY_URL" ]; then
    echo "Error: RECOVERY_URL must be provided."
    exit 1
fi

echo "Fetching recovery image from: $RECOVERY_URL"
wget -O recovery.img.lz4 "$RECOVERY_URL"

# Patch Process-1 (from original script1.sh and run.sh, simplified)
if [ -f recovery.img.lz4 ];then
    echo "Decompressing recovery.img.lz4..."
    lz4 -B6 --content-size -f recovery.img.lz4 recovery.img
fi

# Ensure recovery.img exists
if [ ! -f recovery.img ];then
    echo "Error: recovery.img or recovery.img.lz4 not found."
    exit 1
fi

# Copy recovery.img to r.img to work on it
cp recovery.img r.img

# Create phh.pem if it doesn't exist
if [ ! -f phh.pem ];then
    echo "Creating phh.pem..."
    openssl genrsa -f4 -out phh.pem 4096
fi

# Patch Process-2 (from original script2.sh and run.sh, simplified)
rm -Rf d
mkdir d
cd d

../magiskboot unpack ../r.img
ramdisk=ramdisk.cpio

# Handle vendor_ramdisk if it exists
if [ -f vendor_ramdisk/recovery.cpio ];then
    echo "Using vendor_ramdisk/recovery.cpio..."
    ramdisk=vendor_ramdisk/recovery.cpio
fi

../magiskboot cpio $ramdisk extract

# Apply hexpatches (merged from script2.sh and run.sh)
set +e # Disable exit on error to prevent script from stopping due to hexpatch

../magiskboot hexpatch system/bin/recovery e10313aaf40300aa6ecc009420010034 eec3009420010034
../magiskboot hexpatch system/bin/recovery 3ad3009420010034 3ad3009420010035
../magiskboot hexpatch system/bin/recovery 50c0009420010034 50c0009420010035
../magiskboot hexpatch system/bin/recovery 080109aae800000b4 080109aae800000b5
../magiskboot hexpatch system/bin/recovery 20f0a6ef38b9681c 20f0a6ef38b9681c
../magiskboot hexpatch system/bin/recovery 23f03aed38b9681c 23f03aed38b9681c
../magiskboot hexpatch system/bin/recovery 20f09eef38b1681c 20f09eef38b9681c
../magiskboot hexpatch system/bin/recovery 9ef0ced28b1701c 9ef0ced28b9701c
../magiskboot hexpatch system/bin/recovery 2001597ae0000054 2001597ae1000054 # cmp w9, w25, #0, eq ; b.e #0x20 ===> b.ne #0x20
../magiskboot hexpatch system/bin/recovery 26f0ceec30b9681c 26f0ceec30b9681c
../magiskboot hexpatch system/bin/recovery 24f0ceec30b9681c 24f0ceec30b9681c
../magiskboot hexpatch system/bin/recovery 27f02eeb30b9681c 27f02eeb30b9681c
../magiskboot hexpatch system/bin/recovery b4f082ee28b1701c b4f082ee28b9701c
../magiskboot hexpatch system/bin/recovery 24f02ea30b9681c 24f02ea30b9681c
../magiskboot hexpatch system/bin/recovery 2001597ac0000054 2001597ac1000054 # cmp w9, w25, #0, eq ; b.e #0x1c ===> b.ne #0x1c
../magiskboot hexpatch system/bin/recovery 9ef0ceec28b1701c 9ef0ceec28b9701c
../magiskboot hexpatch system/bin/recovery 41010054a0020012f44f48a9 410100542000085280000014

cp system/bin/recovery ../reco-patched

set -e # Re-enable exit on error

# Repack the image
../magiskboot cpio $ramdisk add 0755 system/bin/recovery system/bin/recovery
../magiskboot repack ../r.img new-boot.img
cp new-boot.img ../recovery-patched.img

cd ..

# avbtool steps from workflow
echo "Applying avbtool..."
python3 avbtool extract_public_key --key phh.pem --output phh.pub.bin
python3 avbtool add_hash_footer --partition_name recovery --partition_size $(wc -c recovery.img |cut -f 1 -d ' ') --image recovery-patched.img --key phh.pem --algorithm SHA256_RSA4096

# Create the final archive
mkdir -p output
mv recovery-patched.img output/recovery.img
tar cvf fastbootd-recovery.tar -C output recovery.img

rm -Rf d

echo "Recovery patching finished. The patched image is fastbootd-recovery.tar"
-algorithm SHA256_RSA4096

# إنشاء الأرشيف النهائي
mkdir -p output
mv recovery-patched.img output/recovery.img
tar cvf fastbootd-recovery.tar -C output recovery.img

rm -Rf d

echo "تم الانتهاء من تصحيح الريكفري. الصورة المصححة هي output/fastbootd-recovery.tar"

