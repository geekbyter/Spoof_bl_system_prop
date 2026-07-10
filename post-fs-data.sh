#!/system/bin/sh
# prop_shield: early boot property overrides

MODDIR="${0%/*}"

# Locate resetprop
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

# Apply overrides as early as possible
"$RESETPROP" partition.system.verified 1 2>/dev/null
"$RESETPROP" partition.vendor.verified 1 2>/dev/null
"$RESETPROP" partition.product.verified 1 2>/dev/null
"$RESETPROP" partition.system_ext.verified 1 2>/dev/null
"$RESETPROP" partition.odm.verified 1 2>/dev/null
"$RESETPROP" ro.oem_unlock_supported 0 2>/dev/null
"$RESETPROP" sys.oem_unlock_allowed 0 2>/dev/null
"$RESETPROP" ro.boot.selinux enforcing 2>/dev/null
"$RESETPROP" ro.build.selinux 1 2>/dev/null