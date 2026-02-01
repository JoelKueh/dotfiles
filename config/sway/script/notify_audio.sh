
ID=264001
VOL=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' '{print $2}' | awk '{gsub(/[ %]/,""); print}')
notify-send -r $ID "Volume: $VOL" --hint=int:value:$VOL
