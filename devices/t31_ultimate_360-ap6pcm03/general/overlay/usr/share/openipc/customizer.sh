#!/bin/sh
#
# 360 AP6PCM03
# SoC: Ingenic T31ZX
# Sensor: GC4653
# Wi-Fi: ATBM6031
#

# Enable OpenIPC plugins
cli -s .system.plugins true

# Set video codec
cli -s .video0.codec h264

# Set Wi-Fi device configuration
fw_setenv wlandev atbm603x-generic

exit 0
