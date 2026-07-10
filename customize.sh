#!/system/bin/sh

# Prop Shield installation script

SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=true
LATESTARTSERVICE=true

ui_print "- Prop Shield v1.0.0"
ui_print "- System property shielding for detection bypass"
ui_print "- Uses resetprop for safe in-memory modification"