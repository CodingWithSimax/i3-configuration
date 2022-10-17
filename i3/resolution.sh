MAKE_CUSTOM_RESOLUTION=false

if [ MAKE_CUSTOM_RESOLUTION = true ] then    
    xrandr --output HDMI-2 --off
    xrandr --output DP-1 --mode 3840x1080 --rate 120
    xrandr --setmonitor DP-1-1 2560/800x1080/340+0+0 DP-1
    xrandr --setmonitor DP-1-2 1280/400x1080/340+2560+0 none
else
    xrandr --output HDMI-2 --mode 1920x1080 --pos 1920x0 --output DP-1 --mode 1920x1080 --pos 0x0
fi

sleep 3

nitrogen --restore
