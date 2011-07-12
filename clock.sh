#!/bin/bash

cols=$(($(tput cols) - 1))
lines=$(($(tput lines) - 1))
midx=$(($cols / 2))
midy=$(($lines / 2))

while true
do
    clear
    second=$(echo "$(date +'%S') / 60" | bc -l)
    minute=$(echo "$(date +'%M') / 60" | bc -l)
    hour=$(echo "$(date +'%l') / 12" | bc -l)
    pi=$(echo "4*a(1)" | bc -l)

    units=($hour $minute $second)
    letters=(H M S)
    for i in {0..2}
    do
        unit=${units[$i]}
        s=$(echo "2 * $pi * ($unit - .25)" | bc -l)

        xmax=$(echo "c($s) * $midx" | bc -l)
        ymax=$(echo "s($s) * $midy" | bc -l)
        length=$(echo "sqrt($xmax ^ 2 + $ymax ^ 2)" | bc -l)
        for l in $(seq 1 $length)
        do
            x=$(echo "$xmax * ($l / $length) + $midx" | bc -l)
            y=$(echo "$ymax * ($l / $length) + $midy" | bc -l)
            tput cup $(printf "%0.f" $y) $(printf "%0.f" $x)
            echo ${letters[$i]}
        done
    done
    
    sleep 1
done

exit 0
