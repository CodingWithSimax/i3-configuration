# echo "---" | tee -a /tmp/polybar1.log
# polybar 2>&1 | tee -a /tmp/polybar1.log & disown
# echo "Bars launched..."

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload &
  done
else
  polybar --reload example &
fi
