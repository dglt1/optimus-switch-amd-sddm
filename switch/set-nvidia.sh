#!/bin/sh

echo 'Removing amd only mode setup......'
rm -f /etc/X11/xorg.conf.d/99-amd.conf
rm -f /etc/modprobe.d/99-amd.conf
rm -f /etc/modules-load.d/99-amd.conf
rm -f /usr/share/sddm/scripts/Xsetup

sleep 1
echo 'Setting nvidia prime mode.......'

cp /etc/switch/nvidia/nvidia-xorg.conf /etc/X11/xorg.conf.d/99-nvidia.conf
cp /etc/switch/nvidia/nvidia-modprobe.conf /etc/modprobe.d/99-nvidia.conf
cp /etc/switch/nvidia/nvidia-modules.conf /etc/modules-load.d/99-nvidia.conf
cp /etc/switch/nvidia/optimus.sh /usr/share/sddm/scripts/Xsetup

sleep 1
echo 'Done! After reboot you will be using nvidia prime mode.'
