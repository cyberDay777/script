#!/bin/bash

echo
echo "--------------------------------------"
echo "          lineageos Buildbot          "
echo "                  by                  "
echo "            CyberDay777.              "
echo "--------------------------------------"
echo
#!/bin/bash

# Define remotes
declare -A remotes
remotes["chenfeng"]="https://github.com/xiaomi-chenfieng-devs"
remotes["peridot-dev"]="https://github.com/peridot-dev"

# Array of project data: path|name|remote
projects=(
  "hardware/qcom-caf/common|android_hardware_qcom-caf_common|chenfeng"
  "hardware/qcom-caf/sm8650/audio/agm|android_vendor_qcom_opensource_agm|chenfeng"
  "hardware/qcom-caf/sm8650/audio/pal|android_vendor_qcom_opensource_arpal-lx|chenfeng"
  "hardware/qcom-caf/sm8650/audio/primary-hal|android_hardware_qcom_audio-ar|chenfeng"
  "hardware/qcom-caf/sm8650/data-ipa-cfg-mgr|android_vendor_qcom_opensource_data-ipa-cfg-mgr|chenfeng"
  "hardware/qcom-caf/sm8650/dataipa|android_vendor_qcom_opensource_dataipa|chenfeng"
  "hardware/qcom-caf/sm8650/display|android_hardware_qcom_display|chenfeng"
  "hardware/qcom-caf/sm8650/media|android_hardware_qcom_media|chenfeng"
  "device/qcom/sepolicy_vndr/sm8650|android_device_qcom_sepolicy_vndr|chenfeng"
  "device/xiaomi/chenfeng|device_xiaomi_chenfeng|chenfeng"
  "vendor/xiaomi/chenfeng|vendor_xiaomi_chenfeng|chenfeng"
  "device/xiaomi/chenfeng-prebuilt|device_xiaomi_chenfeng-kernel|chenfeng"
  "hardware/xiaomi|hardware_xiaomi|chenfeng"
)

# Iterate and process each project
for project in "${projects[@]}"; do
  IFS='|' read -r path name remote <<< "$project"
  echo "Removing $path"
  rm -rf "$path"

  url="${remotes[$remote]}/$name.git"
  echo "Cloning $url into $path"
  git clone "$url" "$path"
done

echo "All specified directories have been removed and repositories cloned."

rm -rf hardware/google/pixel/kernel_headers
#source build/envsetup.sh
#export SELINUX_IGNORE_NEVERALLOWS=true
#breakfast chenfeng
#make clean
#mka bacon
