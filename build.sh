#!/bin/bash

# git clone https://github.com/xiangfeidexiaohuo/Snapdragon-LLVM.git /opt/Snapdragon-clang
# git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 /opt/aarch64-linux-android-4.9
# git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 /opt/arm-linux-androideabi-4.9

CLANG=/opt/Snapdragon-clang/bin
GCC32=/opt/arm-linux-androideabi-4.9/bin
GCC64=/opt/aarch64-linux-android-4.9/bin


export CLANG_TRIPLE=aarch64-linux-gnu
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-
PATH=$CLANG:$GCC64:$GCC32:$PATH
export PATH


# Vars
export HEADER_ARCH=$ARCH
export KBUILD_BUILD_USER=hudsoncm
export KBUILD_BUILD_HOST=ilclbld169


DATE_START=$(date +"%s")
echo "-------------------"
echo "Making Kernel:"
echo "-------------------"
echo

rm -rf out

make -j$(nproc --all) CC=clang O=out ARCH=arm64 O=out nio_defconfig

make -j$(nproc --all) CC=clang O=out ARCH=arm64


echo
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo