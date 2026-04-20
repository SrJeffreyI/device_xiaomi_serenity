#!/bin/bash

# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=missi
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" true

write_headers

write_makefiles "${MY_DIR}/proprietary-files.txt" true

printf '\n%s\n' "BOARD_VENDOR_SEPOLICY_DIRS += vendor/xiaomi/missi/sepolicy" >> "$BOARDMK"
printf '\n%s\n' "TARGET_BOARD_PLATFORM := ums9230" >> "$BOARDMK"
printf '\n%s\n' "TARGET_BOARD_PLATFORM_GPU := mali-g52" >> "$BOARDMK"

cat << EOF >> "$BOARDMK"
# Kernel
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_KERNEL_SOURCE := kernel/xiaomi/missi
TARGET_KERNEL_CONFIG := missi_defconfig
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version \$(BOARD_BOOTIMG_HEADER_VERSION)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 104857600
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product odm
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200

# Properties
TARGET_SYSTEM_PROP += vendor/xiaomi/missi/system.prop
TARGET_VENDOR_PROP += vendor/xiaomi/missi/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := vendor/xiaomi/missi/rootdir/etc/fstab.missi

# Security patch level
VENDOR_SECURITY_PATCH := 2024-03-01

# HIDL
DEVICE_MANIFEST_FILE += vendor/xiaomi/missi/manifest.xml

# VINTF
DEVICE_MATRIX_FILE += vendor/xiaomi/missi/compatibility_matrix.xml

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += vendor/xiaomi/missi/sepolicy

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := vendor/xiaomi/missi/bluetooth

# WiFi
BOARD_WLAN_DEVICE := qca_cld3
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_\$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_\$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
GNSS_HIDL_VERSION := 2.1

# Audio
USE_XML_AUDIO_POLICY_CONF := 1

# Display
TARGET_SCREEN_DENSITY := 440

# Camera
TARGET_USES_QTI_CAMERA_DEVICE := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# FM
BOARD_HAVE_QCOM_FM := true

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Charger
BOARD_CHARGER_ENABLE_SUSPEND := true
EOF

printf '\n%s\n' "PRODUCT_SOONG_NAMESPACES += vendor/xiaomi/missi" >> "$PRODUCTMK"