choice=$(echo -e  "shutdown\nreboot\nlock\nexit" | dmenu)

[ $choice = "shutdown" ] && doas poweroff
[ $choice = "reboot" ] && doas reboot
[ $choice = "lock" ] && slock
[ $choice = "exit" ] && pkill dwm 
