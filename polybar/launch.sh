# echo "---" | tee -a /tmp/polybar1.log
# polybar 2>&1 | tee -a /tmp/polybar1.log & disown
# echo "Bars launched..."

killall polybar

FIRST_TIME=true

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
