# echo "---" | tee -a /tmp/polybar1.log
# polybar 2>&1 | tee -a /tmp/polybar1.log & disown
# echo "Bars launched..."

IS_SUPER_ULTRAWIDE_MONITOR=true
VIRTUAL_SCREEN_NAMES=("DP-1-1" "DP-1-2")

killall polybar

FIRST_TIME=true

if [ "$IS_SUPER_ULTRAWIDE_MONITOR" = true ]; then
    for m in ${VIRTUAL_SCREEN_NAMES[@]}; do 
        if [ "$FIRST_TIME" = true ]; then
          FIRST_TIME=false
          MONITOR=$m TRAY_POSITION=right polybar default --reload &
        else
          MONITOR=$m TRAY_POSITION=none polybar default --reload &
        fi
    done
else
    if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        if [ "$FIRST_TIME" = true ]; then
          FIRST_TIME=false
          MONITOR=$m TRAY_POSITION=right polybar default --reload &
        else
          MONITOR=$m TRAY_POSITION=none polybar default --reload &
        fi
      done
    else
      polybar --reload example &
    fi
fi




