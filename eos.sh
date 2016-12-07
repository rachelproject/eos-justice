#!/bin/bash

APPS_TO_REMOVE="org.kde.Knavalbattle net.sourceforge.Atanks net.sourceforge.Btanks \
com.endlessm.celebrities.en com.endlessm.cooking.en com.endlessm.encyclopedia.en \
org.kde.Killbots net.olofson.Kobodeluxe org.marsshooter.Marsshooter com.endlessm.maternity.en \
org.megaglest.Megaglest org.openarena.Openarena net.sourceforge.Warmux net.wz2100.Warzone2100 \
org.wesnoth.Wesnoth"

APPS_TO_INSTALL="com.google.Chrome org.learningequality.KALite"

REMOVE_USER="shared"
ADD_USER="user"

RSYNC_SERVER=$1
DEST_DIR="/opt"

RACHEL_MODS="en-boundless en-ck12 en-edison en-GCF2015 en-math_expression en-musictheory \
en-oya en-law_library en-phet en-radiolab en-saylor"

function delete_applications {
    echo "Starting applications deleting"
    for APP in $APPS_TO_REMOVE; do
        if `flatpak uninstall $APP`; then
            echo "$APP has been removed"
        else
            echo "Deleting $APP failed"
        fi
    done
    echo "Applications deleting finished"
}

function install_applications {
    echo "Starting applications installiation"
    for APP in $APPS_TO_INSTALL; do
        if `flatpak install eos-apps $APP eos3.0`; then
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

function disable_social_bar {
    echo "Disabling social bar"
    if `gsettings set org.gnome.shell enable-social-bar false`; then
        echo "Social bar has been disabled"
    else
        echo "Social bar disabling failed"
    fi
}

function check_if_root {
    if (( $EUID != 0 )); then
        echo "Please run as root"
        exit 1
    fi
}

function download_rachelusb {
    if [ ! -z "$RSYNC_SERVER" ]; then
        echo "Starting downloading RACHELUSB from rsync server"
        rsync -az --info=progress2 rsync://$RSYNC_SERVER $DEST_DIR
        for RACHEL_MOD in $RACHEL_MODS; do
            rsync -az --info=progress2 rsync://dev.worldpossible.org/rachelmods/$RACHEL_MOD $DEST_DIR
    fi
}

check_if_root
disable_social_bar
delete_applications
install_applications
download_rachelusb
delete_user
create_user
exit 0
