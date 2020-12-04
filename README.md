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

Here is some email traffic that helped me execute the above:

Hi team -

I'm trying to execute "A slightly cleaner way of disabling automatic updates is to copy /usr/share/eos-updater/eos-autoupdater.conf to /etc/eos-updater/ and change LastAutomaticStep=3 to LastAutomaticStep=1, so that way the user will know when an update is available, it just won't be applied automatically"
  
As suggested here, but having trouble with creating eos-updater in "etc" - Operation not permitted -- or -- in edited /usr/share/eos-updater/eos-autoupdater.conf "OS is read-only" 

What command are you using? Does `pkexec mkdir -p /etc/eos-updater` work? That would need to be run by a user with sudo rights.


Jeremy Schwartz <jeremy@worldpossible.org>
Mon, Aug 31, 4:09 PM
to Phaedrus, Deployment

that did work, great -- thank you

I still had to copy /usr/share/eos-updater/eos-autoupdater.conf to my home folder so I could edit eos-autoupdater.conf and then copy it to /etc/eos-updater after using the new command to create that folder. 

Thank you, I'm going to put the device online and see if it avoids updating.



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

the boot/grub/grub.cfg for headless reformatting is here in github also.

## Making Imaging USB
Boot from a clonezilla USB
Use a large SSD as /home/partimag to put clonezilla on a disk
Transfer that image to a clonezilla USB set to autoboot and image
make a copy of that USB with Win32DiskImager
use the .img file in imageUSB to create 4 more master USBs
use imageUSB and the copy devices to make more USBs

## DirHTML Listings
I am using Arclab Dir2HTML

## VirtualBox 
For whatever reason, when I clonezilla off of a Securebook, the resultant image requires enabling EFI on the virtual box https://www.techwalla.com/articles/how-to-get-to-bios-on-virtualbox


## lock screen user switching
dconf write /org/gnome/login-screen/disable-user-list false
gsettings set org.gnome.desktop.screensaver user-switch-enabled true
gsettings set org.gnome.desktop.lockdown disable-user-switching false

## grubx efi fix for no ostree found
WARNING: Please note that this assumes the system is installed to /dev/sda. You'll need to adapt it for your own setup, and getting this wrong has a risk of data loss or breaking the OS.

sudo mount /dev/sda1 /mnt

sudo cp grubx64.efi /mnt/EFI/endless/grubx64.efi

sudo umount /mnt

Also, please note that if the file got corrupted during download or copying, the system will become unbootable and difficult to recover (you'll need to USB-boot, manually mount the ESP from the internal disk and copy a "good" file over it). I recommend verifying that the copy was good using checksums.

A fixed grubx64.efi file can be found in this ZIP, at /EFI/BOOT/grubx64.efi: https://images-dl.endlessm.com/release/3.8.4/eos-amd64-amd64/base/eos-eos3.8-amd64-amd64.200706-185259.base.boot.zip. The SHA256 checksum of this zip file is e2963ee3a2a15019beb439d4418f919c6585cc092ceb94c3c507aac35e85a824, so you can verify your download as well.

Finally, while this is something our developers do as part of their day-to-day activities, this is not a standard procedure we would normally share with partners to be done on their side. It has not been reviewed to the same level of something we would publish as official documentation. So please be cautious and try it first on a test machine that you would not mind too much if things go wrong and you need to do a full reflash, as there may be some errors.

With that final disclaimer, I hope this helps and makes your deployments a bit easier to maintain.


## Disable the self password reset service
In case you don't want anyone or yourself to unlock the computer when losing the password, you can disable it.

Open a terminal then enter:
pkexec --user Debian-gdm dbus-run-session gsettings set org.gnome.shell password-reset-allowed disable

## find recently used apps

maybe of interest - the file ~/.local/share/gnome-shell/application_state  contains a list maintained by the desktop shell of apps by frequency and last use


