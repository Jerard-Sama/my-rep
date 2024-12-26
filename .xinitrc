setxkbmap -layout us,ara -variant ,digits -option grp:sclk_toggle caps:escape
xrandr --output VGA-1 --mode 1360x768
slstatus &
sxhkd &
hsetroot -fill $HOME/gallery/wallpapers/anime/862294.jpg &
xcompmgr &
$HOME/scripts/dynamic_transparency.sh &
xautolock -time 2 -locker slock &
dwm
