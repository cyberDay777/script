#!/bin/bash

echo
echo "--------------------------------------"
echo "          lineageos Buildbot          "
echo "                  by                  "
echo "            CyberDay777.              "
echo "--------------------------------------"
echo
#!/bin/bash

#!/bin/bash

# Define remotes
declare -A remotes
remotes["chenfeng"]="https://github.com/xiaomi-chenfieng-devs"
remotes["peridot-dev"]="https://github.com/peridot-dev"

# Array of project data: path|name|remote|revision(optional)
projects=(
  "hardware/qcom-caf/common|android_hardware_qcom-caf_common|chenfeng|"
  "hardware/qcom-caf/sm8650/audio/agm|android_vendor_qcom_opensource_agm|chenfeng|lineage-22.2-caf-sm8650"
  "hardware/qcom-caf/sm8650/audio/pal|android_vendor_qcom_opensource_arpal-lx|chenfeng|lineage-22.2-caf-sm8650"
  "hardware/qcom-caf/sm8650/audio/primary-hal|android_hardware_qcom_audio-ar|chenfeng|lineage-22.2-caf-sm8650"
  "hardware/qcom-caf/sm8650/data-ipa-cfg-mgr|android_vendor_qcom_opensource_data-ipa-cfg-mgr|chenfeng|lineage-22.2-caf-sm8650"
  "hardware/qcom-caf/sm8650/dataipa|android_vendor_qcom_opensource_dataipa|chenfeng|lineage-22.2-caf-sm8650"
  "hardware/qcom-caf/sm8650/display|android_hardware_qcom_display|chenfeng|lineage-22.2-caf-sm8650"
  "hardware/qcom-caf/sm8650/media|android_hardware_qcom_media|chenfeng|lineage-22.2-caf-sm8650"
  "device/qcom/sepolicy_vndr/sm8650|android_device_qcom_sepolicy_vndr|chenfeng|lineage-22.2-caf-sm8650"
  "device/xiaomi/chenfeng|device_xiaomi_chenfeng|chenfeng|lineage-22.2"
  "vendor/xiaomi/chenfeng|vendor_xiaomi_chenfeng|chenfeng|main"
  "device/xiaomi/chenfeng-prebuilt|device_xiaomi_chenfeng-kernel|chenfeng|lineage-22.2"
  "hardware/xiaomi|hardware_xiaomi|chenfeng|lineage-22.2"
)

for project in "${projects[@]}"; do
  IFS='|' read -r path name remote revision <<< "$project"
  echo "Removing $path"
  rm -rf "$path"

  url="${remotes[$remote]}/$name.git"
  echo "Cloning $url into $path"
  if [[ -n "$revision" ]]; then
    git clone -b "$revision" "$url" "$path"
  else
    git clone "$url" "$path"
  fi
done

echo "All specified directories have been removed and repositories cloned."
rm -rf hardware/google/pixel/kernel_headers
source build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
breakfast chenfeng
make clean
mka bacon
