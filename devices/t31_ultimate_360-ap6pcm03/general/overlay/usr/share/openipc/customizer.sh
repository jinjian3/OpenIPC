#!/bin/sh
# Device defaults for Qihoo 360 AP6PCM03 (T31ZX + GC4653), applied on first boot
# and after `sysupgrade -n`.
cli -s .system.plugins true
cli -s .video0.codec h264

# Audio: 16 kHz is required, the driver rejects the 640-byte playback frames at 8 kHz
cli -s .audio.enabled true
cli -s .audio.srate 16000
cli -s .audio.volume 70
cli -s .audio.gain 26
cli -s .audio.outputVolume 29
cli -s .audio.outputGain 16
cli -s .audio.speakerPin 63

# Night mode: IR-cut coils and IR LED
cli -s .nightMode.irCutPin1 60
cli -s .nightMode.irCutPin2 59
cli -s .nightMode.backlightPin 14

# Image mounted upside down
cli -s .image.mirror true
cli -s .image.flip true

# Network: Wi-Fi + Ethernet, cable preferred
fw_setenv wlandev atbm603x-generic
fw_setenv netmode dual

# Memory split
fw_setenv osmem 66M@0x0
fw_setenv rmem 62M@0x4200000

exit 0
