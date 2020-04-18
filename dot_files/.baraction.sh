#!/bin/bash
# baraction.sh for spectrwm status bar
# Source: https://gitlab.com/dwt1/dotfiles/-/blob/master/baraction.sh

## DATE
dte() {
    dte="$(date +"%A, %m/%d/%Y %T")"
    echo -e "$dte"
}

## DISK
hdd() {
    hdd="$(df -h | awk 'NR==4{print $3, $5}')"
    echo -e "HDD: $hdd"
}

## RAM
mem() {
    mem=`free | awk '/Mem/ {printf "%d MiB/%d MiB\n", $3 / 1024.0, $2 / 1024.0 }'`
    echo -e "MEM: $mem"
}

## CPU
cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo -e "CPU: $cpu%"
}

## VOLUME
vol() {
    vol=`pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'`
    echo -e "VOL: $vol"
}

## LOCAL IP
local_ip() {
    my_ip=$(ip address | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -E '^192')
    echo -e "IPv4: $my_ip"
}

SLEEP_SEC=1
#loops forever outputting a line every SLEEP_SEC secs
while :; do
    echo "$(local_ip) | $(cpu) | $(mem) | $(hdd) | $(vol) | $(dte)"
    sleep $SLEEP_SEC
done
