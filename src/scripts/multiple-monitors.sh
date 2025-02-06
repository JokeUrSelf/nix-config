xrandr --auto

connected_outputs=$(xrandr --listmonitors | awk '/\+/ { gsub(/^\+\*/, "", $2); print $2 }')

primary_monitor=$(echo "$connected_outputs" | head -n 1)
second_monitor=$(echo "$connected_outputs" | awk 'NR==2')

xrandr --output "$second_monitor" --above "$primary_monitor" --auto
