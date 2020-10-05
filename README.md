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

## DirHTML Listings
I am using Arclab Dir2HTML

## VirtualBox 
For whatever reason, when I clonezilla off of a Securebook, the resultant image requires enabling EFI on the virtual box https://www.techwalla.com/articles/how-to-get-to-bios-on-virtualbox
