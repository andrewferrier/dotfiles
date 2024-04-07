if [[ $TTY == "/dev/tty1" ]]; then
    if type X &>/dev/null; then
        echo "Press a key to interrupt starting X..."
        IFS= read -k -t 1.5; RETVAL=$?
        if [ $RETVAL -ne 0 ]; then
            echo "Starting X..."
            # Repeat rate using 'xset r' and xorg.conf doesn't seem reliable
            exec startx -- -ardelay 250 -arinterval 15
        fi
    fi
fi
