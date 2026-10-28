#!/bin/sh
#
# 360 AP6PCM03
# SoC: Ingenic T31ZX, Sensor: GC4653, Wi-Fi: ATBM6031 (SDIO)
#
# Runs once on first boot (S30customizer).
# Wi-Fi SSID/password are NOT stored here (public repo). Set them on the camera:
#   fw_setenv wlanssid 'SSID'; fw_setenv wlanpass 'PASSWORD'

cli -s .system.plugins true
cli -s .video0.codec h264
chmod +x /etc/init.d/S39wifiprep /etc/wireless/sdio
cli -s .audio.enabled true

fw_setenv wlandev atbm603x-generic
fw_setenv netmode wifi
fw_setenv osmem 66M@0x0
fw_setenv rmem 62M@0x4200000

exit 0
