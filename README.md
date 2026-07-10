# Spoof_bl_prop

A Magisk/APatch/KernelSU module that spoofs bootloader and system properties to bypass detection apps.

## What It Spoofs

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

## How It Works

Uses `resetprop` (available in APatch, Magisk, KernelSU) to modify properties in memory. No disk modifications, no kernel hooks, no Zygisk injection.

Properties are applied at two stages:
1. `post-fs-data.sh` — early boot
2. `service.sh` — after `sys.boot_completed=1`

## Install

```bash
# Via APatch
apd module install Spoof_bl_prop-v1.0.0.zip

# Via Magisk
magisk --install-module Spoof_bl_prop-v1.0.0.zip
```

Reboot after install.

## Compatibility

- Android 10+
- APatch / FolkPatch
- Magisk
- KernelSU

## Build

```bash
zip -r9 Spoof_bl_prop-v1.0.0.zip module.prop customize.sh post-fs-data.sh service.sh META-INF/
```

Or push to GitHub — Actions will build automatically.

## License

Apache 2.0