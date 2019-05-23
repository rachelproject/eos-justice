# eos-justice
changes to eos for justice setting

## Usage
`wget -nv -O - https://raw.githubusercontent.com/rachelproject/eos-justice/master/eos.sh | sudo bash -s -- rsync_argument`,
`wget https://raw.githubusercontent.com/rachelproject/eos-justice/master/eos.sh
where `rsync_argument` is a part of the rsync url after `rsync://`, e.g. `user@host/module/path`.

`-s -- rsync_argument` part can be omitted otherwise the script will try to download RACHELUSB from the rsync server.

##Remove online accounts
https://help.gnome.org/admin/system-admin-guide/stable/lockdown-online-accounts.html.en
