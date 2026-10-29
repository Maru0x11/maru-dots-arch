#! /bin/bash 

set -e 

# use igpu for everything 
export WLR_DRM_DEVICES=/dev/dri/by-path/pci-0000:00:02.0-card

# ensure xdg-portal is running 
systemctl --user restart xdg-desktop-portal & 

# also run wlr cuz some apps need it 
/usr/lib/xdg-desktop-portal-wlr  >/dev/null 2>&1 &

# # night light
# wlsunset >/dev/null 2>&1 &
#

# bar 
qs >/dev/null 2>&1 &


# wallpaper 
 awww-daemon >/dev/null 2>&1 &



#TODO: implement a wallpaper picker

# applets 
blueman-applet >/dev/null 2>&1 & 
nm-applet >/dev/null 2>&1 &

# polkit for permession auth 
/usr/lib/xfce-polkit/xfce-polkit >/dev/null 2>&1 &

#clipboard manager
cliphist wipe
wl-paste --type image --watch cliphist store
wl-paste --type text --watch cliphist store



# IME 
fcitx5 --replace -d >/dev/null 2>&1 &

#swayosd 
swayosd-server >/dev/null 2>&1 &

#notifications 
dunst & >/dev/null 2>&1 &
