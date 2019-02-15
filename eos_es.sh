#!/bin/bash

SCHEMA_PATH="/usr/share/glib-2.0/schemas/50_eos-theme.gschema.override"

APPS_TO_REMOVE="org.kde.Knavalbattle net.sourceforge.Atanks net.sourceforge.Btanks \
com.endlessm.celebrities.en com.endlessm.cooking.en com.endlessm.encyclopedia.en \
org.kde.Killbots net.olofson.Kobodeluxe org.marsshooter.Marsshooter com.endlessm.maternity.en \
org.megaglest.Megaglest org.openarena.Openarena net.sourceforge.Warmux net.wz2100.Warzone2100 \
org.wesnoth.Wesnoth com.endlessm.videonet com.endlessm.weather"

APPS_TO_INSTALL="com.google.Chrome org.learningequality.KALite com.arduino.App org.snap4arduino.App \
org.processing.App org.codeblocks.App org.gnome.Builder com.google.AndroidStudio"

REMOVE_USER="shared"
ADD_USER="user"

if [ ! -z "$1" ]; then
    RSYNC_SERVER=$1
else
    RSYNC_SERVER="dev.worldpossible.org"
fi

DEST_DIR="/opt"
KALITE_CONTENT="/var/lib/kalite"
RACHEL_MODS="en-boundless en-ck12 en-edison en-GCF2015 en-math_expression en-musictheory \
en-oya en-law_library en-PhET en-radiolab en-saylor"

TASKBAR_PINS="['google-chrome.desktop', 'org.gnome.Software.desktop', 'org.gnome.Nautilus.desktop']"
DESKTOP_GRID="{'desktop': ['google-chrome.desktop', 'rachel_bookmark1.desktop', 'rachel_bookmark2.desktop', \
'rachel_bookmark3.desktop', 'rachel_bookmark4.desktop', 'rachel_bookmark5.desktop', \
'org.gnome.Nautilus.desktop', 'libreoffice-writer.desktop', 'rhythmbox.desktop', \
'com.endlessm.photos.desktop', 'com.endlessm.encyclopedia.en.desktop', 'net.minetest.Minetest.desktop', \
'com.endlessm.videonet.desktop', 'eos-folder-media.directory', 'eos-folder-work.directory', \
'eos-folder-curiosity.directory', 'eos-folder-social.directory', 'org.learningequality.KALite.desktop'], \
'eos-folder-media.directory': ['shotwell.desktop', 'org.gnome.Totem.desktop', \
'net.sourceforge.Audacity.desktop', 'org.tuxpaint.Tuxpaint.desktop', 'org.gimp.Gimp.desktop'], \
'eos-folder-work.directory': ['libreoffice-calc.desktop', 'libreoffice-impress.desktop', \
'gnome-calculator.desktop', 'com.endlessm.finance.desktop', 'com.endlessm.resume.desktop', \
'com.endlessm.translation.desktop'], 'eos-folder-curiosity.directory': \
['com.endlessm.cooking.en.desktop', 'com.endlessm.celebrities.en.desktop', \
'com.endlessm.myths.en.desktop', 'com.endlessm.math.en.desktop', 'com.endlessm.howto.en.desktop', \
'com.endlessm.travel.en.desktop', 'com.endlessm.health.en.desktop', 'kde4-org.kde.Marble.desktop', \
'eos-link-duolingo.desktop'], 'eos-folder-social.directory': ['eos-link-facebook.desktop', \
'eos-link-whatsapp.desktop', 'evolution.desktop', 'eos-link-gmail.desktop']}"

DEVICE=`mount | grep /usr | cut -d " " -f 1`

BOOKMARK_TEMPLATE="
[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Exec=gvfs-open {path}\n\
X-Endless-LaunchMaximized=true\n\
Name={name}"

BOOKMARK1="/var/opt/rachelusb_32JU/RACHEL/index.html:Home"
BOOKMARK2="/var/opt/rachelusb_32JU/RACHEL/modules/en-GCF2015/index.html:125+_Free_Tutorials_at_GCFLearnFree.org"
BOOKMARK3="/var/opt/rachelusb_32JU/RACHEL/modules/en-rachelcourses/index.html:College_Credit_Courses_from_World_Possible"
BOOKMARK4="/var/opt/rachelusb_32JU/RACHEL/modules/en-oya-static/index.html:Education_Portal_Course_Index"
BOOKMARK5="/var/opt/rachelusb_32JU/RACHEL/modules/saylor/content/www.saylor.org/books.html:Saylor_Academy_Open_Textbooks"
BOOKMARKS=( $BOOKMARK1 $BOOKMARK2 $BOOKMARK3 $BOOKMARK4 $BOOKMARK5 )

function delete_applications {
    echo "Starting to delete applications"
    for APP in $APPS_TO_REMOVE; do
        flatpak uninstall $APP
        if [ $? -eq 0 ]; then
            echo "$APP has been removed"
        else
            echo "Deleting $APP failed"
        fi
    done
    echo "Applications deleting finished"
}

function install_applications {
    echo "Starting to install applications"
    for APP in $APPS_TO_INSTALL; do
        flatpak install eos-apps $APP eos3.3
        if [ $? -eq 0 ]; then
            echo "$APP has been installed"
        else
            echo "$APP installation failed"
        fi
    done
    echo "Applications installation finished"   
}

function delete_user {
    echo "Starting to delete $REMOVE_USER user"
    if `userdel $REMOVE_USER`; then
        echo "User $REMOVE_USER has been successfully deleted"
    else
        echo "Deleting $REMOVE_USER user failed"
    fi
}

function create_user {
    echo "Starting to create new user"
    if `useradd -c "$ADD_USER" -m -s "/bin/bash" $ADD_USER`; then
        echo "User has been created"
        echo $ADD_USER:"123456" | chpasswd
        chage -d 0 $ADD_USER
    else
        echo "User adding failed"
    fi
}

function put_bookmarks {
    echo "Creating bookmarks"
    i=1
    for bookmark in "${BOOKMARKS[@]}"; do
        path=`echo $bookmark | cut -d : -f 1`
        name=`echo $bookmark | cut -d : -f 2`
        echo -e $BOOKMARK_TEMPLATE | sed -e "s~{path}~$path~g;s/{name}/$name/g" > /usr/share/applications/rachel_bookmark$i.desktop
        ((i++))
    done
}

function tweak_desktop {
    echo "Tweaking desktop defaults"
    echo -e "[org.gnome.shell]\ntaskbar-pins=$TASKBAR_PINS\n" >> $SCHEMA_PATH
    echo -e "[org.gnome.shell]\nenable-social-bar=false\n" >> $SCHEMA_PATH
    sed -i "s/\(icon-grid-layout=\)\(.*\)/\1$DESKTOP_GRID/" $SCHEMA_PATH
    glib-compile-schemas /usr/share/glib-2.0/schemas/
}

function check_if_root {
    if (( $EUID != 0 )); then
        echo "Please run as root"
        exit 1
    fi
}

function download_rachelusb {
    echo "Starting to download RACHELUSB from rsync server"
    rsync -az --info=progress2 rsync://$RSYNC_SERVER $DEST_DIR
    for RACHEL_MOD in $RACHEL_MODS; do
        rsync -az --info=progress2 rsync://$RSYNC_SERVER/rachelmods/$RACHEL_MOD $DEST_DIR
    done
}

function download_kalite_content {
    echo "Starting to download KA Lite content"
    rsync -az --info=progress2 rsync://$RSYNC_SERVER/rachelmods/en-kalite/content $KALITE_CONTENT
    echo "Replacing the DB"
    rsync -az --info=progress2 rsync://$RSYNC_SERVER/rachelmods/en-kalite/content_khan_en.sqlite $KALITE_CONTENT/database/
    chown kalite:kalite $KALITE_CONTENT/database/content_khan_en.sqlite
    chmod 644 $KALITE_CONTENT/database/content_khan_en.sqlite
}

check_if_root
mount -o remount,rw $DEVICE /usr
delete_applications
install_applications
download_rachelusb
download_kalite_content
put_bookmarks
tweak_desktop
delete_user
create_user
exit 0
