# Spoof_bl_prop

A Magisk/APatch/KernelSU module that spoofs system properties to bypass detection apps.

## What It Does

This module modifies the following system properties in memory (no disk modifications):

### Bootloader Properties
| Property | Original | Spoofed |
|----------|----------|---------|
| `partition.system.verified` | `2` | `1` |
| `partition.vendor.verified` | `2` | `1` |
| `partition.product.verified` | `2` | `1` |
| `partition.system_ext.verified` | `2` | `1` |
| `partition.odm.verified` | `2` | `1` |
| `ro.oem_unlock_supported` | `1` | `0` |
| `sys.oem_unlock_allowed` | `1` | `0` |

### System Properties
| Property | Original | Spoofed |
|----------|----------|---------|
| `ro.boot.selinux` | (empty) | `enforcing` |
| `ro.build.selinux` | (empty) | `1` |
| `persist.sys.usb.config` | `adb` | `mtp` |
| `sys.usb.config` | `adb` | `mtp` |
| `sys.usb.state` | `adb` | `mtp` |

## Features

- **In-memory modification**: Uses `resetprop` for safe, non-destructive property modification
- **Universal compatibility**: Works with APatch, Magisk, and KernelSU
- **No disk changes**: Properties are modified in memory only, safe to reboot
- **ADB preserved**: USB config is sanitized but ADB functionality remains intact
- **Boot-time application**: Properties are set early in boot process

## Installation

1. Download the latest release zip
2. Install via your root manager (Magisk/APatch/KernelSU)
3. Reboot your device

## Compatibility

- Android 10+
- APatch/FolkPatch
- Magisk
- KernelSU

## How It Works

The module uses `resetprop` (available in APatch, Magisk, and KernelSU) to modify system properties in memory. This is the same technique used by the root managers themselves.

The modifications are applied at two stages:
1. **post-fs-data**: Early boot (before most services start)
2. **service**: After boot completes (ensures all properties are set)

## Safety

- No disk modifications
- No kernel modifications
- No hook installations
- Properties reset on reboot
- ADB functionality preserved

## Building

### Local Build
```bash
cd module
zip -r ../Spoof_bl_prop-v1.0.0.zip module.prop customize.sh post-fs-data.sh service.sh META-INF/
```

### GitHub Actions
The repository includes a GitHub Actions workflow that automatically builds the module on push to main.

## License

Apache 2.0