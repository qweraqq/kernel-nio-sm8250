#!/bin/bash

# git clone https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r445002 --depth=1 --single-branch --no-tags -b 12.0 /opt/clang-r445002
# git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 -b android-12.1.0_r27 --depth=1 --single-branch --no-tags /opt/aarch64-linux-android-4.9
# git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9 -b android-12.1.0_r27 --depth=1 --single-branch --no-tags /opt/arm-linux-androideabi-4.9

CLANG=/opt/clang-r416183b1/bin
GCC32=/opt/arm-linux-androideabi-4.9/bin
GCC64=/opt/aarch64-linux-android-4.9/bin


export CLANG_TRIPLE=aarch64-linux-gnu
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-
export LD_LIBRARY_PATH=/opt/clang-r416183b/lib64:/usr/local/lib:$LD_LIBRARY_PATH
PATH=$CLANG:$GCC64:$GCC32:$PATH
export PATH


# Vars
export ARCH=arm64
export SUBARCH=$ARCH
export HEADER_ARCH=$ARCH
export KBUILD_BUILD_USER=hudsoncm
export KBUILD_BUILD_HOST=ilclbld169


DATE_START=$(date +"%s")
echo "-------------------"
echo "Making Kernel:"
echo "-------------------"
echo

# rm -rf out
# make O=out clean && make mrproper

make -j$(nproc --all) CC=clang O=out ARCH=arm64 O=out vendor/kona-perf_defconfig vendor/ext_config/moto-kona.config vendor/ext_config/nio-default.config

make -j$(nproc --all) CC=clang O=out ARCH=arm64

# make CC="ccache clang" CXX="ccache clang++" LLVM=1 LLVM_IAS=1 O=out $DEFCONFIG
# make CC='ccache clang' CXX="ccache clang++" LLVM=1 LLVM_IAS=1 O=out $THREAD \
#     LOCALVERSION=-Android12-9-00001-g41ff3fa8fff9-ab8171928 \
#     CONFIG_LOCALVERSION_AUTO=n \
#     CONFIG_MEDIATEK_CPUFREQ_DEBUG=m CONFIG_MTK_IPI=m CONFIG_MTK_TINYSYS_MCUPM_SUPPORT=m \
#     CONFIG_MTK_MBOX=m CONFIG_RPMSG_MTK=m CONFIG_LTO_CLANG=y CONFIG_LTO_NONE=n \
#     CONFIG_LTO_CLANG_THIN=y CONFIG_LTO_CLANG_FULL=n 2>&1 | tee kernel.log

echo
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo