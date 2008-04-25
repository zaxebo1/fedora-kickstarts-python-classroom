# Fedora Project Spin 
# (c) Rahul Sundaram <sundaram@fedoraproject.org>
# GPlv2 or later

%include /usr/share/livecd-tools/livecd-fedora-base-desktop.ks
repo --name=raw --priority=1 --baseurl=http://nighthawk.pnq.redhat.com/nightly/latest-Rawhide/i386/os/
selinux --enforcing


%packages

firefox
NetworkManager-vpnc
NetworkManager-openvpn
NetworkManager-gnome

# we don't include @office so that we don't get OOo.  but some nice bits

abiword
gnumeric
evince
-evince-dvi
gimp
inkscape
galculator
desktop-backgrounds-compat
xscreensaver-base
setroubleshoot

# development 
geany


# More Desktop stuff 

xdg-user-dirs
@java
totem
-totem-xine
totem-mozplugin
pidgin
claws-mail
brasero
drivel
liferea
quodlibet
gftp
mirage
tracker-search-tool

gnome-power-manager
seahorse
transmission
cups-pdf
bluez-gnome
alsa-plugins-pulseaudio

# Command line


ntfs-3g
powertop
wget
irssi
mutt
yum-utils

# xfce packages

# xfce packages
@xfce-desktop
gtk-xfce-engine
orage
xarchiver


xfce4-taskmanager
thunar-volman


xfce4-battery-plugin
xfce4-clipman-plugin
xfce4-cpugraph-plugin
xfce4-datetime-plugin
xfce4-dict-plugin
xfce4-diskperf-plugin
xfce4-genmon-plugin
#redundant with verve plugin
#xfce4-minicmd-plugin
xfce4-mount-plugin
xfce4-netload-plugin
xfce4-notes-plugin
xfce4-places-plugin
xfce4-quicklauncher-plugin
xfce4-screenshooter-plugin
xfce4-sensors-plugin
xfce4-systemload-plugin
xfce4-volstatus-icon
xfce4-verve-plugin
#we use NetworkManager-gnome. So this is redundant  
xfce4-weather-plugin
xfce4-websearch-plugin

# this one a compatibility layer for GNOME applets and depends on it
#xfce4-xfapplet-plugin

xfwm4-themes


# dictionaries are big
-aspell-*
-man-pages-*
-scim-tables-*
-wqy-bitmap-fonts
-dejavu-fonts-experimental
-dejavu-fonts

# drop more fonts

-lohit-fonts-*
-thaifonts-scalable
-paktype-fonts
-VLGothic-fonts
-baekmuk-ttf-fonts-*
-kacst-fonts
-lklug-fonts
-jomolhari-fonts
-abyssinica-fonts
-cjkunifonts-uming

# more fun with space saving 
-scim-lang-chinese
scim-chewing
scim-pinyin
-gimp-help

# save some space
-autofs
-nss_db
-sendmail

#system-config-printer does printer management better
#xfprint has now been made as optional in comps.

system-config-printer


%end

%post


# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
EOF

mkdir -p /home/fedora/.config/tracker
cat > /home/fedora/.config/tracker/tracker.cfg <<EOF
[Indexing]
EnableIndexing=false
Language=en
EOF


mkdir -p /root/.config/tracker
cat > /root/.config/tracker/tracker.cfg <<EOF
[Indexing]
EnableIndexing=false
Language=en
EOF


cat >> /etc/rc.d/init.d/fedora-live << EOF
chown -R fedora:fedora /home/fedora

# set up timed auto-login for after 10 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=fedora
TimedLoginDelay=10
FOE


if [ -e /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png ] ; then
    cp /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png /home/fedora/.face
    chown fedora:fedora /home/fedora/.face
    # TODO: would be nice to get e-d-s to pick this one up too... but how?
fi

EOF
%end