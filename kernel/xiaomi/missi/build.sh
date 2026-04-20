#!/bin/bash

# Kernel build script for Xiaomi Missi
# Unisoc UMS9230

set -e

KERNEL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANDROID_ROOT="${KERNEL_DIR}/../../.."
KERNEL_OUT="${ANDROID_ROOT}/out/target/product/missi/obj/KERNEL_OBJ"

# Toolchain
ARCH=arm64
CROSS_COMPILE="${ANDROID_ROOT}/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-"

# Number of CPU cores
JOBS=$(nproc)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${GREEN}=== $1 ===${NC}"
}

print_error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[WARNING] $1${NC}"
}

# Main
print_header "Xiaomi Missi Kernel Build"
print_header "Starting build process..."

# Create output directory
mkdir -p "${KERNEL_OUT}"

# Configure kernel
print_header "Configuring kernel..."
cd "${KERNEL_DIR}"
make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} O=${KERNEL_OUT} missi_defconfig

# Build kernel
print_header "Building kernel..."
make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} O=${KERNEL_OUT} -j${JOBS}

# Build modules
print_header "Building kernel modules..."
make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} O=${KERNEL_OUT} INSTALL_MOD_PATH=${KERNEL_OUT}/mods modules_install 2>/dev/null || true

# Copy artifacts
print_header "Copying build artifacts..."
cp "${KERNEL_OUT}/arch/arm64/boot/Image" "${KERNEL_OUT}/kernel-dtb" 2>/dev/null || true
cp "${KERNEL_OUT}/arch/arm64/boot/dts/dtbo.dtb" "${KERNEL_OUT}/dtbo.dtb" 2>/dev/null || true

print_header "Kernel build completed successfully!"
print_warning "Kernel output: ${KERNEL_OUT}"

exit 0
