#!/bin/sh

# Turn keyboard backlight off
echo '0' > /sys/devices/platform/dell-laptop/leds/dell\:\:kbd_backlight/brightness

# I have been trying to permanently disable my keyboard backlight for months now...
# This is a linux service I made (/etc/init.d/keyboard_backlight) that runs on
# boot to ensure my keyboard backlight is turned off.
# I highly doubt anyone will ever read this or if they do, care, but I don't
# want to lose this and forget what it does...

# So with Ubuntu 20.04 I haven't actually needed this.
# Before 20.04 I actual had to add this to /etc/init.d
# and start this new service. Still didnt 100% work all the time. idk why
# was a lost cause... till 20.04 came along and fixed it I guess.
