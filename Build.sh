#!/bin/bash

echo
echo "--------------------------------------"
echo "          lineageos Buildbot          "
echo "                  by                  "
echo "            CyberDay777.              "
echo "--------------------------------------"
echo
rm -rf device/xiaomi/chenfeng
git clone https://github.com/cyberDay777/device_xiaomi_chenfeng.git device/xiaomi/chenfeng
rm -rf kernel/xiaomi/chenfeng
git clone https://github.com/cyberDay777/Xiaomi_Kernel_OpenSource.git kernel/xiaomi/chenfeng
rm-rf device/xiaomi/chenfeng-prebuilt
git clone https://github.com/cyberDay777/device_xiaomi_chenfeng-kernel.git device/xiaomi/chenfeng-prebuilt
rm -rf vendor/xiaomi/chenfeng
git clone https://github.com/cyberDay777/vendor_xiaomi_chenfeng.git vendor/xiaomi/chenfeng
rm -rf prebuilts/clang/host/linux-x86/clang-r450784d
git clone https://gitlab.com/ImSurajxD/clang-r450784d.git prebuilts/clang/host/linux-x86/clang-r450784d
export PATH="$HOME/tmp/src/android/prebuilts/clang/host/linux-x86/clang-r450784d/bin:$PATH"
rm -rf hardware/google/pixel/kernel_headers
source build/envsetup.sh
lunch lineage_chenfeng-bp1a-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
make bacon
