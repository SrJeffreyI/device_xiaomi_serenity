# Xiaomi Redmi Note 13 4G (missi) - LineageOS 22.1

Device tree for Xiaomi Redmi Note 13 4G (missi) based on Unisoc UMS9230 chipset.

## Status
- **Maintainer**: [Your Name]
- **Current version**: Android 15 (LineageOS 22.1)
- **Status**: Work in progress

## Device specifications
- **Chipset**: Unisoc UMS9230
- **CPU**: Octa-core (2x2.0 GHz Cortex-A75 & 6x1.8 GHz Cortex-A55)
- **GPU**: Mali-G52
- **RAM**: 4GB/8GB LPDDR4X
- **Storage**: 128GB/256GB UFS 2.2
- **Display**: 6.67" FHD+ AMOLED, 120Hz
- **Rear camera**: 108MP + 8MP + 2MP
- **Front camera**: 16MP
- **Battery**: 5000mAh
- **OS**: Android 13 (HyperOS)

## What's working
- [ ] Boot
- [ ] Display
- [ ] Touch
- [ ] Audio
- [ ] Camera
- [ ] WiFi
- [ ] Bluetooth
- [ ] GPS
- [ ] Sensors
- [ ] NFC
- [ ] Fingerprint
- [ ] USB
- [ ] Charging

## Build instructions

1. Setup LineageOS build environment
2. Clone this device tree:
   ```bash
   git clone https://github.com/yourusername/android_device_xiaomi_missi -b lineage-22.1 device/xiaomi/missi
   ```
3. Clone vendor blobs:
   ```bash
   git clone https://github.com/yourusername/android_vendor_xiaomi_missi -b lineage-22.1 vendor/xiaomi/missi
   ```
4. Build:
   ```bash
   source build/envsetup.sh
   lunch lineage_missi-userdebug
   make bacon
   ```

## Credits
- @sebaubuntu-python for aospdtgen and device tree extraction tools
- Xiaomi for kernel source
- LineageOS team

## License
This device tree is licensed under Apache License 2.0.