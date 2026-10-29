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
# executable bits and pin setup: see muxes.sh (runs on every boot)
cli -s .audio.enabled true

cli -s .image.mirror true
cli -s .image.flip true

# Day/night: IR-cut coil pins (pulse driven), IR LED, speaker amplifier enable.
# Pin numbers come from the stock firmware (libysx_vid.so); if the picture is pink
# in daylight, swap irCutPin1 and irCutPin2.
cli -s .nightMode.irCutPin1 60
cli -s .nightMode.irCutPin2 59
cli -s .nightMode.backlightPin 14
cli -s .audio.speakerPin 63

fw_setenv wlandev atbm603x-generic
fw_setenv netmode dual
fw_setenv osmem 66M@0x0
fw_setenv rmem 62M@0x4200000

exit 0
