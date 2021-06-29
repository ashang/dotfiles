
## The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
date_formatted=$(date "+%a %F %H:%M")

# "upower --enumerate | grep 'BAT'" gets the battery name (e.g.,
# "/org/freedesktop/UPower/devices/battery_BAT0") from all power devices.
# "upower --show-info" prints battery information from which we get
# the state (such as "charging" or "fully-charged") and the battery's
# charge percentage. With awk, we cut away the column containing
# identifiers. i3 and sway convert the newline between battery state and
# the charge percentage automatically to a space, producing a result like
# "charging 59%" or "fully-charged 100%".
#battery_info=$(upower --show-info $(upower --enumerate |\
#grep 'BAT') |\
#egrep "state|percentage" |\
#awk '{print $2}')

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_info=$(cat /sys/class/power_supply/BAT0/status)

# "amixer -M" gets the mapped volume for evaluating the percentage which
# is more natural to the human ear according to "man amixer".
# Column number 4 contains the current volume percentage in brackets, e.g.,
# "[36%]". Column number 6 is "[off]" or "[on]" depending on whether sound
# is muted or not.
# "tr -d []" removes brackets around the volume.
# Adapted from https://bbs.archlinux.org/viewtopic.php?id=89648
audio_volume=$(amixer -M get Master |\
awk '/Mono.+/ {print $6=="[off]" ?\
$4" 🔇": \
$4" 🔉"}' |\
tr -d [])

# libupower-glib, libasound and libnm to retrieve battery, volume and network information as opposed to using upower, amixer or nmcli.

# backlight, load, and meminfo, reads from /sys/class/backlight, /proc/loadavg and /proc/meminfo.

# Emojis and characters for the status bar
# Electricity: ⚡ ↯ ⭍ 🔌
# Audio: 🔈 🔊 🎧 🎶 🎵 🎤
# Separators: \| ❘ ❙ ❚
# Misc: 🐧 💎 💻 💡 ⭐ 📁 ↑ ↓ ✉ ✅ ❎

#echo $uptime_formatted ↑ $linux_version 🐧 $battery_status 🔋 $date_formatted
echo $audio_volume $battery_info 🔋 $date_formatted
