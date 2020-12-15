#!/bin/sh

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

####################################
# custom install script for   SDDM #
# and following GPU BusID's        #
# ryzen iGPU BusID  05:00:0        #
# nvidia dGPU BusID  01:00:0       #
# chmod +x install.sh  first!      #
####################################

echo '##################################################################'
echo '# be sure you have all requirements BEFORE running this script  ##'
echo '# linux*-headers acpi_call-dkms xf86-video-amdgpu git xorg-xrandr##'
echo '# ****installing in 5 sec... CTRL+C to abort****                ##'
echo '##################################################################'
sleep 6
echo ' '
echo '##################################################################'
echo '#errors about removing files can be ignored, i wrote this script##'
echo '#with the most common files in mind, you will not have all of   ##'
echo '#them, this is ok!                                              ##'
echo '##################################################################'
echo '## IF YOU HAVE ERRORS ABOUT COPYING FILES, SOMETHING IS WRONG   ##'
echo '## MAKE SURE THIS IS RUN WITH SUDO AND FROM DIRECTORY           ##'
echo '## /home/$USER/optimus-switch/  (this is very important!!!)     ##'
echo '##################################################################'
sleep 5

echo ' '
echo 'Removing current nvidia prime setup if applicable, file not found can be ignored......'
rm -f /etc/X11/mhwd.d/nvidia.conf
rm -f /etc/X11/mhwd.d/nvidia.conf.nvidia-xconfig-original
rm -f /usr/share/sddm/scripts/Xsetup
echo 'rm -f /etc/X11/mhwd.d/nvidia.conf*'
rm -f /etc/X11/xorg.conf.d/90-mhwd.conf
rm -f /etc/X11/xorg.conf.d/20-intel.conf
rm -f /etc/X11/xorg.conf.d/20-amdgpu.conf
rm -f /etc/X11/xorg.conf.d/nvidia.conf
rm -f /etc/X11/xorg.conf.d/optimus.conf
echo 'rm -f /etc/X11/xorg.conf.d/90-mhwd.conf'
rm -f /etc/modprobe.d/mhwd-gpu.conf
rm -f /etc/modprobe.d/optimus.conf
rm -f /etc/modprobe.d/nvidia.conf
echo 'rm -f /etc/modprobe.d/mhwd-gpu.conf'
rm -f /etc/modprobe.d/nvidia-drm.conf
rm -f /etc/modprobe.d/nvidia.conf
echo 'rm -f /etc/modprobe.d/nvidia*.conf'
rm -f /etc/modules-load.d/mhwd-gpu.conf
echo 'rm -f /etc/modules-load.d/mhwd-gpu.conf'
rm -f /usr/local/bin/optimus.sh
rm -f /usr/local/share/optimus.desktop
echo 'rm -f /usr/local/share/optimus.desktop'
sleep 2

echo 'Copying contents of ~/optimus-switch-amd-sddm/* to /etc/ .......'
mkdir /etc/switch/
cp -r * /etc/
#mkdir /etc/lightdm/lightdm.conf.d
#cp /etc/switch/lightdm.conf /etc/lightdm/lightdm.conf.d/lightdm.conf
sleep 2
echo 'Copying set-amd.sh and set-nvidia.sh to /usr/local/bin/'

cp /etc/switch/set-amd.sh /usr/local/bin/set-amd.sh

cp /etc/switch/set-nvidia.sh /usr/local/bin/set-nvidia.sh

###This section not needed for LightDM but can be used if want, its not required.
#cp /etc/switch/optimus.desktop /usr/local/share/optimus.desktop
#sleep 1
#echo 'Copying disable-nvidia.service to /etc/systemd/system/' 
#cp /etc/switch/amd/disable-nvidia.service /etc/systemd/system/disable-nvidia.service
#chown root:root /etc/systemd/system/disable-nvidia.service
#chmod 644 /etc/systemd/system/disable-nvidia.service

sleep 1
echo 'Setting nvidia prime mode (sudo set-nvidia.sh).......'

cp /etc/switch/nvidia/nvidia-xorg.conf /etc/X11/xorg.conf.d/99-nvidia.conf
cp /etc/switch/nvidia/nvidia-modprobe.conf /etc/modprobe.d/99-nvidia.conf
cp /etc/switch/nvidia/nvidia-modules.conf /etc/modules-load.d/99-nvidia.conf
cp /etc/switch/nvidia/optimus.sh /usr/share/sddm/scripts/Xsetup

sleep 1
echo 'Setting permissions........'
chmod +x /usr/local/bin/set-amd.sh
chmod +x /usr/local/bin/set-nvidia.sh
chmod a+rx /usr/share/sddm/scripts/Xsetup
chmod a+rx /etc/switch/amd/no-optimus.sh
chmod a+rx /etc/switch/nvidia/optimus.sh
chmod +x /etc/switch/gpu_switch_check.sh

sleep 1
echo 'Currently boot mode is set to nvidia prime.'
echo 'you can switch to amd only mode with sudo set-amd.sh and reboot.'
echo 'same can be done for nvidia prime mode with sudo set-nvidia.sh'

sleep 1
echo 'Install finished!'



