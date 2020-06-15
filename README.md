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
