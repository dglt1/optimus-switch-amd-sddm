#!/bin/sh

#optimus-switch (LightDM) uninstall script.

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo 'Removing optimus-switch'

rm -f /usr/local/bin/set-amd.sh
rm -f /usr/local/bin/set-nvidia.sh
rm -f /usr/local/bin/optimus.sh
rm -f /usr/share/sddm/scripts/Xsetup
rm -rf /etc/switch

systemctl disable disable-nvidia.service
rm -f /etc/systemd/system/disable-nvidia.service

rm -f /etc/X11/mhwd.d/99-nvidia.conf
rm -f /etc/X11/xorg.conf.d/99-nvidia.conf
rm -f /etc/modprobe.d/99-nvidia.conf
rm -f /etc/modules-load.d/99-nvidia.conf

rm -f /etc/X11/xorg.conf.d/99-amd.conf
rm -f /etc/modprobe.d/99-amd.conf
rm -f /etc/modules-load.d/99-amd.conf

sleep 1
echo 'optimus-switch is now uninstalled'
echo '########'
echo 'if you reboot now, you will not have a working Xorg setup.'
echo 'setup another optimus solution before rebooting.'
rm -f uninstall-switch.sh 
