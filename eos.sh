#!/bin/bash

SCHEMA_PATH="/usr/share/glib-2.0/schemas/50_eos-theme.gschema.override"

APPS_TO_REMOVE="com.endlessm.biology.en com.endlessm.celebrities.en com.endlessm.encyclopedia.en \
com.endlessm.health.en com.endlessm.healthy_teeth.en com.endlessm.howto.en com.endlessm.maternity.en \
com.endlessm.soccer.en com.endlessm.socialsciences.en com.endlessm.travel.en com.endlessm.wiki_art.en \
com.teeworlds.Teeworlds net.olofson.KoboDeluxe \
net.sourceforge.atanks net.sourceforge.btanks net.sourceforge.chromium-bsu net.sourceforge.ExtremeTuxRacer \
net.sourceforge.mars-game net.sourceforge.Ri-li net.sourceforge.torcs net.sourceforge.SuperTuxKart \
net.wz2100.wz2100 org.armagetronad.ArmagetronAdvanced org.audacityteam.Audacity \
org.gna.Warmux org.gnome.Weather org.kde.kigo org.kde.killbots \
org.kde.klines org.kde.knetwalk org.megaglest.MegaGlest org.wesnoth.Wesnoth ws.openarena.OpenArena"

APPS_TO_INSTALL="org.learningequality.KALite \
com.endlessm.vroom.en \
com.endlessm.ubongo_kids_demo \
com.endlessm.programming \
com.endlessm.programming_guide.en \
en.endlessm.bible.en en.endlessm.green_curriculum.en \
info.bibletime.BibleTime \
com.endlessnetwork.csstutorials \
com.endlessm.disabilities.en\
com.endlessm.animals.en \
com.endlessm.astronomy.en \
com.endlessm.CompanionAppService \
com.endlessm.dinosaurs.en \
com.endlessm.disabilities.en \
com.endlessm.EknServicesMultiplexer \
com.endlessm.farming.en \
com.endlessm.finance \
com.endlessm.geography.en \
com.endlessm.green_curriculum.en \
com.endlessm.history.en \
#com.endlessm.ingles_con_rodrigo.es \
com.endlessm.math.en \
com.endlessm.myths.en \
com.endlessm.photos \
com.endlessm.physics.en \
com.endlessm.programming \
com.endlessm.programming_guide.en \
com.endlessm.resume \
com.endlessm.soccer.en \
com.endlessm.socialsciences.en \
#com.endlessm.textbooks.en \
com.endlessm.travel.en \
com.endlessm.video_animal_kingdom \
com.endlessm.vroom.en \
com.github.labyrinth_team.labyrinth \
com.github.ryanakca.slingshot \
com.google.Chrome \
com.tux4kids.tuxmath \
com.tux4kids.tuxtype \
fr.free.Homebank \
io.thp.numptyphysics \
net.blockout.BlockOutII \
net.minetest.Minetest \
net.sourceforge.atanks \
net.sourceforge.btanks \
net.sourceforge.chromium-bsu \
net.sourceforge.ExtremeTuxRacer \
net.sourceforge.Ri-li \
#net.sourceforge.torcs \
net.sourceforge.TuxFootball \
#net.supertuxkart.SuperTuxKart \
org.armagetronad.ArmagetronAdvanced \
org.audacityteam.Audacity \
org.debian.TuxPuck \
org.freeciv.Freeciv \
org.frozen_bubble.frozen-bubble \
org.gimp.GIMP \
org.gnome.Aisleriot \
org.gnome.Genius \
org.gnome.Gnote \
org.gnome.iagno \
org.gnome.quadrapassel \
org.gnome.tetravex \
org.gnome.Weather \
org.inkscape.Inkscape \
org.kde.gcompris \
org.kde.kalzium \
org.kde.kapman \
org.kde.katomic \
org.kde.kblocks \
org.kde.kbounce \
org.kde.kbruch \
org.kde.kdiamond \
org.kde.kgeography \
org.kde.kgoldrunner \
org.kde.khangman \
org.kde.kigo \
org.kde.kjumpingcube \
org.kde.klickety \
org.kde.klines \
org.kde.knavalbattle \
org.kde.knetwalk \
org.kde.ksquares \
org.kde.ksudoku \
org.kde.ktuberling \
org.kde.kubrick \
org.kde.kwordquiz \
org.kde.palapeli \
org.laptop.TurtleArtActivity \
org.learningequality.KALite \
org.libreoffice.LibreOffice \
org.mozilla.Firefox \
org.openscad.OpenSCAD \
org.pitivi.Pitivi \
org.seul.pingus \
org.speedcrunch.SpeedCrunch \
org.squeakland.Scratch \
org.stellarium.Stellarium \
org.supertuxproject.SuperTux \
org.tuxfamily.XMoto \
org.tuxpaint.Tuxpaint \
"


REMOVE_USER="shared"
ADD_USER="user"

if [ ! -z "$1" ]; then
    RSYNC_SERVER=$1
else
    RSYNC_SERVER="192.168.1.10"
fi

DEST_DIR="/opt"
KALITE_CONTENT="/var/lib/kalite"
RACHEL_MODS="rachelusb_32JU_1.21/rachelusb_32JU_1.21"

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
        flatpak uninstall -y $APP
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
        flatpak install -y eos-apps $APP
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
        rsync -az --info=progress2 rsync://$RSYNC_SERVER/all/$RACHEL_MOD $DEST_DIR
    done
    echo "Cleaning up RACHEL"
    rm $DEST_DIR/RACHEL/modules/en-learnsaylor/course/nanking.pdf
    rm $DEST_DIR/RACHEL/modules/en-learnsaylor/mod/page/RobertMapplethorpeArtworks.pdf
    rm $DEST_DIR/RACHEL/modules/en-learnsaylor/mod/page/bihbbqzl96y.mp4
    rm $DEST_DIR/RACHEL/modules/en-learnsaylor/mod/page/bihbbqzl96y.png
    rm $DEST_DIR/RACHEL/modules/wikipedia-for-schools/images/2727/272728.png
    rm $DEST_DIR/RACHEL/modules/wikipedia-for-schools/images/2727/272732.jpg
    rm $DEST_DIR/RACHEL/modules/wikipedia-for-schools/images/2727/272733.jpg
    rm $DEST_DIR/RACHEL/modules/wikipedia-for-schools/images/2727/272734.jpg
    rm $DEST_DIR/RACHEL/modules/wikipedia-for-schools/images/2727/272735.jpg
    rm $DEST_DIR/RACHEL/modules/wikipedia-for-schools/images/2727/272736.jpg
    rm $DEST_DIR/RACHEL/modules/wikipedia-for-schools/images/2727/272737.jpg
    rm $DEST_DIR/RACHEL/modules/wikipedia-for-schools/images/2727/272738.jpg
}

function download_kalite_content {
    echo "Starting to download KA Lite content"
    rsync -az --info=progress2 rsync://$RSYNC_SERVER/rachelmods/en-kalite/content $KALITE_CONTENT
    echo "YOU NEED OT MANUALLY REPLACE THE DATABASE WITH ANOTHER EN V16.5 DB"
    #rsync -az --info=progress2 rsync://$RSYNC_SERVER/rachelmods/en-kalite/content_khan_en.sqlite $KALITE_CONTENT/database/
    #chown kalite:kalite $KALITE_CONTENT/database/content_khan_en.sqlite
    #chmod 644 $KALITE_CONTENT/database/content_khan_en.sqlite
}

function content_cleanup {
    echo "cleaning up preinstalled endless-content"
    rm -r /var/endless-content/music/*
    rm -r /var/endless-content/pictures/*
    rm -r /var/endless-content/videos/*
}
       

check_if_root
mount -o remount,rw $DEVICE /usr
delete_applications
install_applications
download_rachelusb
download_kalite_content
#content_cleanup
#put_bookmarks
#tweak_desktop
#delete_user
#create_user
exit 0
