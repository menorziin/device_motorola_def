# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

VENDOR_EXCEPTION_PATHS := lineage \
    motorola \
    gapps

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_BUILD_PRODUCT_IMAGE  := true
PRODUCT_BUILD_ODM_IMAGE := false

BOARD_SUPER_PARTITION_SIZE := 9730785280
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9730785280
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# enable to generate super_empy.img if needed to wipe super partition table
#BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST += \
    vendor

BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 209715200
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 209715200
BOARD_EXT4_SHARE_DUP_BLOCKS := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864

PRODUCT_BUILD_RAMDISK_IMAGE := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
TARGET_NO_RECOVERY := false
#BOARD_INCLUDE_RECOVERY_DTBO = true
BOARD_BUILD_RETROFIT_DYNAMIC_PARTITIONS_OTA_PACKAGE := false
BOARD_USES_RECOVERY_AS_BOOT := false

# A/B UPDATER
AB_OTA_UPDATER := true

# Overlay
DEVICE_PACKAGE_OVERLAYS += device/motorola/def/overlay/device

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# get the rest of aosp stuff after ours
$(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system_arm64.mk)

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/motorola/def/device.mk)

PRODUCT_SHIPPING_API_LEVEL := 29

# Discard inherited values and use our own instead.
PRODUCT_NAME := lineage_def
PRODUCT_DEVICE := def
PRODUCT_BRAND := motorola
PRODUCT_MANUFACTURER := motorola
PRODUCT_MODEL := motorola one hyper

TARGET_DEVICE := MotoOneHyper
PRODUCT_SYSTEM_NAME := MotoOneHyper

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DISC="def_retail-user 10 QPF30.103-21-1 3932d release-keys"

BUILD_FINGERPRINT := "google/redfin/redfin:11/RQ3A.210605.005/7349499:user/release-keys"

PLATFORM_SECURITY_PATCH_OVERRIDE := 2019-10-05

TARGET_VENDOR := motorola

$(call inherit-product, vendor/motorola/def/def-vendor.mk)

# Gapps
TARGET_GAPPS_ARCH := arm64

# BootAnimation
TARGET_BOOT_ANIMATION_RES := 1080
