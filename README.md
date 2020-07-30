# eos-justice
changes to eos for justice setting

## Usage
`wget -nv -O - https://raw.githubusercontent.com/rachelproject/eos-justice/master/eos.sh | sudo bash -s -- rsync_argument`,
where `rsync_argument` is a part of the rsync url after `rsync://`, e.g. `user@host/module/path`.

#or just to DL script
`wget https://raw.githubusercontent.com/rachelproject/eos-justice/master/eos.sh

`-s -- rsync_argument` part can be omitted otherwise the script will try to download RACHELUSB from the rsync server.

##Remove online accounts
https://help.gnome.org/admin/system-admin-guide/stable/lockdown-online-accounts.html.en

## Helpful stuff
'KA-Lite is installed at /var/lib/kalite'

'Flatpak list at /var/lib/flatpak/app'

command to see how much storage files take up 'sudo du -d 0 -BM *'

' flatpak uninstall -y $APP'

##to create a bootable usb - take RACHEL image, edit EFI/boot/grub.cfg and replace RACHEL-V3 with clonezilla image and point grub.cfg to clonezilla image and 'sda'



## English Desktop JSON

json path/file: "/var/lib/eos-image-defaults/icon-grid/icon-grid-C.json

Our custom apps are stored at:
This is the desktop shortcut path: /usr/local/share/applications/

AppEditor Flatpak can provide helpful clues

adding .desktop to the name of a flatpak seems to work 98% of the time when adding items to icon-grid-C.json

org.learningequality.KALite
com.endlessm.vroom.en
com.endlessm.resume
com.endlessm.textbooks.en
fr.free.Homebank 
com.endlessm.finance
com.tux4kids.tuxtype
org.squeakland.Scratch
com.endlessm.world_literature.en
org.stellarium.Stellarium
com.endlessm.travel.en
com.endlessm.video_animal_kingdom

## Automatic Updates
disable them:

systemctl mask --now eos-autoupdater.service

re-enable them:
systemctl unmask eos-autoupdater.service

A slightly cleaner way of disabling automatic updates is to copy /usr/share/eos-updater/eos-autoupdater.conf to /etc/eos-updater/ and change `LastAutomaticStep=3` to `LastAutomaticStep=1`, so that way the user will know when an update is available, it just won't be applied automatically.


## Resize Disk
when putting the smaller (240GB) Clonezilla image on a 480GB drive

terminal
sudo parted
resizepart
fix
3
yes
479GB
quit

then in terminal
sudo resize2fs /dev/sda3

reboot and check df -h

## Gnome Settings
https://help.gnome.org/admin/system-admin-guide/stable/logout-automatic.html.en

## Clonezilla
First, make sure disk is MBR formatted https://docs.microsoft.com/en-us/windows-server/storage/disk-management/change-a-gpt-disk-into-an-mbr-disk#:~:text=Back%20up%20or%20move%20all,click%20Convert%20to%20MBR%20disk.

Converting using a command line
Back up or move all volumes on the basic GPT disk you want to convert into an MBR disk.

Open an elevated command prompt by right-clicking Command Prompt and then choosing Run as Administrator.

Type diskpart. If the disk contains no partitions or volumes, skip to step 6.

At the DISKPART prompt, type list disk. Note the disk number that you want to delete.

At the DISKPART prompt, type select disk <disknumber>.

At the DISKPART prompt, type clean.

 Important

Running the clean command will delete all partitions or volumes on the disk.

At the DISKPART prompt, type convert mbr.

Then. Disk must be FAT32, mn2f-portable software will convert NTFS to FAT32

Afer imaging with Clonezilla, a double check can be In the utils folder x64there is a makeboot.bat file which must be run as admin.

This only works sometimes, must also make sure disk is "MBR" formatted. https://docs.microsoft.com/en-us/windows-server/storage/disk-management/change-a-gpt-disk-into-an-mbr-disk#:~:text=Back%20up%20or%20move%20all,click%20Convert%20to%20MBR%20disk.

boot\grub\grub.cfg configured as:
#
set pref=/boot/grub
set default="0"

# Load graphics (only corresponding ones will be found)
# (U)EFI
insmod efi_gop
insmod efi_uga
# legacy BIOS
# insmod vbe

if loadfont $pref/unicode.pf2; then
  set gfxmode=auto
  insmod gfxterm
  terminal_output gfxterm
fi
set timeout="2"
set hidden_timeout_quiet=false

insmod png
if background_image $pref/ocswp-grub2.png; then
  set color_normal=black/black
  set color_highlight=magenta/black
else
  set color_normal=cyan/blue
  set color_highlight=white/blue
fi

# Uncomment the following for serial console
# The command serial initializes the serial unit 0 with the speed 38400bps.
# The serial unit 0 is usually called ‘COM1’. If COM2, use ‘--unit=1’ instead.
#serial --unit=0 --speed=38400
#terminal_input serial
#terminal_output serial

# Decide if the commands: linux/initrd (default) or linuxefi/initrdefi
set linux_cmd=linux
set initrd_cmd=initrd
export linux_cmd initrd_cmd
if [ "${grub_platform}" = "efi" -a -e "/amd64-release.txt" ]; then
  # Only amd64 release we switch to linuxefi/initrdefi since it works better with security boot (shim)
  set linux_cmd=linuxefi
  set initrd_cmd=initrdefi
fi

insmod play
play 960 440 1 0 4 440 1

# Since no network setting in the squashfs image, therefore if ip=, the network is disabled.

menuentry "Clonezilla live (Securebook Recover)" --id live-default {
  search --set -f /live/vmlinuz
  $linux_cmd /live/vmlinuz boot=live union=overlay username=user config components quiet noswap edd=on nomodeset locales=en_US.UTF-8 keyboard-layouts=NONE ocs_live_run="ocs-live-restore" ocs_live_extra_param="-g auto -e1 auto -e2 -r -j2 -scr -batch -p poweroff restoredisk eos-383-wadcyf_v3-securebook-cz_image sda" ocs_live_batch="yes" vga=788 ip= net.ifnames=0 quiet splash i915.blacklist=yes radeonhd.blacklist=yes nouveau.blacklist=yes vmwgfx.enable_fbdev=1
  $initrd_cmd /live/initrd.img
}


## DirHTML Listings
I am using Arclab Dir2HTML
