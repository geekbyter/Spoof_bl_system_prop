#!/system/bin/sh
# prop_shield: apply property overrides after boot
# Uses resetprop (APatch/Magisk/KernelSU) for safe in-memory modification

MODDIR="${0%/*}"

# Wait for system to be ready
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 1
done

# Additional delay to ensure all services are started
sleep 5

# Locate resetprop (supports APatch, Magisk, KernelSU)
RESETPROP=""
for p in /data/adb/ap/bin/resetprop /data/adb/magisk/resetprop /data/adb/ksu/bin/resetprop; do
    if [ -x "$p" ]; then
        RESETPROP="$p"
        break
    fi
done

if [ -z "$RESETPROP" ]; then
    exit 0
fi

# Partition dm-verity: 2 -> 1
"$RESETPROP" partition.system.verified 1
"$RESETPROP" partition.vendor.verified 1
"$RESETPROP" partition.product.verified 1
"$RESETPROP" partition.system_ext.verified 1
"$RESETPROP" partition.odm.verified 1

# OEM unlock: 1 -> 0
"$RESETPROP" ro.oem_unlock_supported 0
"$RESETPROP" sys.oem_unlock_allowed 0

# SELinux state
"$RESETPROP" ro.boot.selinux enforcing
"$RESETPROP" ro.build.selinux 1

# USB config: strip "adb" token, preserve other modes
for p in persist.sys.usb.config sys.usb.config sys.usb.state; do
    v=$(getprop "$p")
    # Remove adb token while preserving other modes
    v=$(echo "$v" | sed 's/,adb//g;s/adb,//g;s/^adb$//')
    v=$(echo "$v" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    # Default to mtp if empty
    [ -z "$v" ] && v="mtp"
    "$RESETPROP" "$p" "$v"
done

exit 0