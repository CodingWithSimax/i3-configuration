MAKE_CUSTOM_RESOLUTION=true

# if [ MAKE_CUSTOM_RESOLUTION = true ]; then    
xrandr --output HDMI-1 --off
xrandr --output DP-0 --mode 3840x1080 --rate 120
xrandr --setmonitor DP-1-1 1920/600x1080/340+0+0 DP-0
xrandr --setmonitor DP-1-2 1920/600x1080/340+1920+0 none
# else
    # xrandr --output HDMI-1 --mode 1920x1080 --pos 1920x0 --output DP-0 --mode 1920x1080 --pos 0x0
# fi
