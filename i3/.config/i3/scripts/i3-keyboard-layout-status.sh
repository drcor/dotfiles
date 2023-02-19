#!/bin/bash

# shell script to prepend i3status with more stuff

i3status | while :
do
    read line
    LG=$(setxkbmap -query | awk '/layout/{print $2}')

    dat="[{ \"full_text\": \"LG: $LG\", \"color\": \"#FF0000\" },"
    echo "${line/[/$dat}" || exit 1
done

