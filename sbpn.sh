if [ -f /sys/class/power_supply/BAT1/power_now ]; then
    # check if the status of the battery charging
    if [ $(cat /sys/class/power_supply/BAT1/status) == "Charging" ]; then
        STATUS="+";
    else 
        STATUS="-";
    fi

    WH=$(bc <<< 'scale=3;'$(cat /sys/class/power_supply/BAT1/power_now)/1000000)
    if [ $WH > 0 ]; then
        echo $STATUS$(bc <<< 'scale=3;'$(cat /sys/class/power_supply/BAT1/power_now)/1000000)' wh'
    else 
        echo $STATUS$(bc <<< 'scale=3;'$(cat /sys/class/power_supply/BAT0/power_now)/1000000)' wh'
    fi
else
    if [ $(cat /sys/class/power_supply/BAT0/status) == "Charging" ]; then
        STATUS="+";
    else 
        STATUS="-";
    fi
    echo $STATUS$(bc <<< 'scale=3;'$(cat /sys/class/power_supply/BAT0/power_now)/1000000)' wh'
fi