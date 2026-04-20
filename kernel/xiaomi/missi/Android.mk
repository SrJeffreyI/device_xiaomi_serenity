# Android.mk for Kernel Build
# Xiaomi Missi (Unisoc UMS9230)

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),missi)

KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
KERNEL_CONFIG := $(KERNEL_OUT)/.config
KERNEL_MODULES_OUT := $(TARGET_OUT)/lib/modules
KERNEL_CROSS_COMPILE := $(PWD)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-

$(KERNEL_OUT)/arch/arm64/boot/Image: $(KERNEL_CONFIG)
	$(MAKE) -C $(KERNEL_OUT) ARCH=arm64 CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) -j$(shell nproc)

$(KERNEL_CONFIG): kernel/xiaomi/missi/missi_defconfig
	mkdir -p $(KERNEL_OUT)
	$(MAKE) -C kernel/xiaomi/missi O=$(KERNEL_OUT) ARCH=arm64 CROSS_COMPILE=$(KERNEL_CROSS_COMPILE) missi_defconfig

# DTBO target
$(KERNEL_OUT)/arch/arm64/boot/dtbo.img: $(KERNEL_OUT)/arch/arm64/boot/Image
	python $(LOCAL_PATH)/../../../tools/mkdtimg create $(KERNEL_OUT)/arch/arm64/boot/dtbo.img --page_size=4096 $(KERNEL_OUT)/arch/arm64/boot/dts/dtbo.dtb

.PHONY: kernel-clean
kernel-clean:
	rm -rf $(KERNEL_OUT)

endif
