#!/bin/bash

mkdir unpack
cd unpack
../magiskboot unpack ../recovery.img
../magiskboot cpio ramdisk.cpio extract

# phh patches
../magiskboot hexpatch system/bin/recovery e10313aaf40300aa6ecc009420010034 e10313aaf40300aa6ecc0094
../magiskboot hexpatch system/bin/recovery eec3009420010034 eec3009420010035
../magiskboot hexpatch system/bin/recovery 3ad3009420010034 3ad3009420010035
../magiskboot hexpatch system/bin/recovery 50c0009420010034 50c0009420010035
../magiskboot hexpatch system/bin/recovery 080109aae80000b4 080109aae80000b5
../magiskboot hexpatch system/bin/recovery 20f0a6ef38b1681c 20f0a6ef38b9681c
../magiskboot hexpatch system/bin/recovery 23f03aed38b1681c 23f03aed38b9681c
../magiskboot hexpatch system/bin/recovery 20f09eef38b1681c 20f09eef38b9681c
../magiskboot hexpatch system/bin/recovery 26f0ceec30b1681c 26f0ceec30b9681c
../magiskboot hexpatch system/bin/recovery 24f0fcee30b1681c 24f0fcee30b9681c
../magiskboot hexpatch system/bin/recovery 27f02eeb30b1681c 27f02eeb30b9681c
../magiskboot hexpatch system/bin/recovery b4f082ee28b1701c b4f082ee28b970c1
../magiskboot hexpatch system/bin/recovery 9ef0f4ec28b1701c 9ef0f4ec28b9701c
../magiskboot hexpatch system/bin/recovery 9ef00ced28b1701c 9ef00ced28b9701c
../magiskboot hexpatch system/bin/recovery 2001597ae0000054 2001597ae1000054
../magiskboot hexpatch system/bin/recovery 2001597ac0000054 2001597ac1000054
../magiskboot hexpatch system/bin/recovery 9ef0fcec28b1701c 9ef0fced28b1701c
../magiskboot hexpatch system/bin/recovery 9ef00ced28b1701c 9ef00ced28b9701c
../magiskboot hexpatch system/bin/recovery 24f0f2ea30b1681c 24f0f2ea30b9681c
../magiskboot hexpatch system/bin/recovery e0031f2a8e000014 200080528e000014
../magiskboot hexpatch system/bin/recovery 41010054a0020012f44f48a9 4101005420008052f44f48a9

# Ravindu644 patches github.com/ravindu644
# One UI 7 - Galaxy A16 5G patches, Issue #4
../magiskboot hexpatch system/bin/recovery 9b880494e0031f2a 9b88049420008052
../magiskboot hexpatch system/bin/recovery 38880494f3031f2a 3888049433008052
# One UI 6 - Galaxy A16 5G patches
../magiskboot hexpatch system/bin/recovery b3860494e0031f2a b386049420008052
../magiskboot hexpatch system/bin/recovery 50860494f3031f2a 5086049433008052
# Galaxy S25, Issue #7
../magiskboot hexpatch system/bin/recovery 7abb0594e0031f2a 7abb059420008052
# Galaxy S24, Issue #5
../magiskboot hexpatch system/bin/recovery 86940494e0031f2a 8694049420008052
../magiskboot hexpatch system/bin/recovery 2c940494f3031f2a 2c94049433008052
# Galaxy S23fe
../magiskboot hexpatch system/bin/recovery a81640f9a9835ff81f0109eb21010054e003142a a81640f9a9835ff81f0109eb2101005420008052
# A556E
../magiskboot hexpatch system/bin/recovery 47a00494e0031f2a 47a0049420008052
../magiskboot hexpatch system/bin/recovery e89f0494f3031f2a e89f049433008052
# SM-M145F, UI 6.1
../magiskboot hexpatch system/bin/recovery 21010054e003142af44f48a9 2101005420008052f44f48a9
../magiskboot hexpatch system/bin/recovery 0ef70394f4031f2a 0ef7039434008052
../magiskboot hexpatch system/bin/recovery f4031f2a737a2491 34008052737a2491
../magiskboot hexpatch system/bin/recovery f4031f2a73e62191 3400805273e62191
../magiskboot hexpatch system/bin/recovery f4031f2a0c000014 340080520c000014
# SM-M215F
../magiskboot hexpatch system/bin/recovery 13faffb0f4031f2a 13faffb034008052
../magiskboot hexpatch system/bin/recovery f3f9fff0f4031f2a f3f9fff034008052
../magiskboot hexpatch system/bin/recovery cafdff54f4031f2a cafdff5434008052
../magiskboot hexpatch system/bin/recovery ab4a0394f4031f2a ab4a039434008052
# SM-A015F (32-Bit)
../magiskboot hexpatch system/bin/recovery 884203d1284609b0 884203d1012009b0
../magiskboot hexpatch system/bin/recovery 2548002578442ce0 2548012578442ce0
../magiskboot hexpatch system/bin/recovery 28480025784430e0 28480125784430e0
../magiskboot hexpatch system/bin/recovery 1a29efda002511e0 1a29efda012511e0
../magiskboot hexpatch system/bin/recovery 7844b4f0a0ed0025 7844b4f0a0ed0125
# SM-A346E
../magiskboot hexpatch system/bin/recovery 2bc50694e0031f2a 2bc5069420008052
../magiskboot hexpatch system/bin/recovery e7c50694f4031f2a e7c5069434008052
# Galaxy S23 Series, Z Flip5, Z Fold5, Issue #11 (Korean Model, One UI 7)
../magiskboot hexpatch system/bin/recovery 9b110494e0031f2a09000014 9b1104942000805209000014

../magiskboot cpio ramdisk.cpio 'add 0755 system/bin/recovery system/bin/recovery'
../magiskboot repack ../recovery.img new-boot.img
cp new-boot.img ../recovery-patched.img
echo "Patched successfully"
