#!/bin/sh
#
# 360 AP6PCM03: board-specific pin setup. S30customizer runs this with "sh" on
# EVERY boot, before the network starts, so it does not depend on file modes.
#
# Files that init executes directly (the Wi-Fi profile, the ptz command) must carry
# the executable bit; GitHub web uploads and some git setups store them as 0644,
# so set it here (idempotent).
chmod +x /etc/wireless/sdio /usr/sbin/ptz 2>/dev/null

# 62 = PTZ motor select (1 = tilt by default), 53 = stock rc.local enables it too
# 52 = sub-board power (Ethernet PHY, speaker, PTZ motor drivers): keep it on.
# 63 (speaker amp) and 59/60/14 (IR-cut, IR LED) are claimed by majestic itself.
for n in 62 53 52; do
	[ -d /sys/class/gpio/gpio$n ] || echo $n > /sys/class/gpio/export
	echo out > /sys/class/gpio/gpio$n/direction
	echo 1 > /sys/class/gpio/gpio$n/value
done

# LED: 51 = blue, 54 = green, high = on
for n in 51 54; do
	[ -d /sys/class/gpio/gpio$n ] || echo $n > /sys/class/gpio/export
	echo out > /sys/class/gpio/gpio$n/direction
done
echo 1 > /sys/class/gpio/gpio51/value
echo 0 > /sys/class/gpio/gpio54/value
(
	i=0
	while [ $i -lt 90 ]; do
		if ip route | grep -q '^default'; then
			echo 0 > /sys/class/gpio/gpio51/value
			echo 1 > /sys/class/gpio/gpio54/value
			break
		fi
		i=$((i + 1))
		sleep 1
	done
) >/dev/null 2>&1 &

# Wi-Fi: MSC1 pins PA8-11, PA16, PA17 -> function 3 (stock kernel table "msc1-pA")
devmem 0x10017018 32 0x30f00
devmem 0x10017028 32 0x30f00
devmem 0x10017034 32 0x30f00
devmem 0x10017044 32 0x30f00
devmem 0x100170F0 32 0

# Wi-Fi: same steps as the "atbm603x-generic" profile in /etc/wireless/sdio, repeated
# here so that Wi-Fi comes up even if that file is not executable.
mmc=/sys/devices/platform/jzmmc_v1.2.1/present
[ "$(cat $mmc 2>/dev/null)" = "N" ] && echo INSERT > $mmc
cp -f /usr/share/atbm60xx_conf/atbm_txpwer_dcxo_cfg.txt /tmp/
cp -f /usr/share/atbm60xx_conf/set_rate_power.txt /tmp/
modprobe atbm603x_wifi_sdio atbm_printk_mask=0

exit 0
