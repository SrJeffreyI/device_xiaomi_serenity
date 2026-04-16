$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_arm64.mk)
$(call inherit-product, device/xiaomi/serenity/device.mk)

PRODUCT_DEVICE := serenity
PRODUCT_NAME := twrp_serenity
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi A5
PRODUCT_MANUFACTURER := xiaomi
