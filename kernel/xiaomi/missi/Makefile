# Makefile for Xiaomi Missi Kernel
# Unisoc UMS9230 based device

ARCH ?= arm64
CROSS_COMPILE ?= aarch64-linux-android-
KERNEL_OUT ?= out
KERNEL_CONFIG := missi_defconfig

# Default target
.DEFAULT_GOAL := all

.PHONY: all clean mrproper

all: $(KERNEL_CONFIG)
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNEL_OUT) KBUILD_OUTPUT=$(KERNEL_OUT)

$(KERNEL_CONFIG):
	mkdir -p $(KERNEL_OUT)
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(KERNEL_OUT) missi_defconfig

menuconfig:
	mkdir -p $(KERNEL_OUT)
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) O=$(KERNEL_OUT) menuconfig

clean:
	rm -rf $(KERNEL_OUT)

mrproper: clean
	find . -name '*.o' -o -name '*.a' | xargs rm -f

help:
	@echo "Xiaomi Missi Kernel Build"
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  all          - Build kernel (default)"
	@echo "  clean        - Clean build output"
	@echo "  menuconfig   - Interactive kernel configuration"
	@echo "  help         - Show this help message"
