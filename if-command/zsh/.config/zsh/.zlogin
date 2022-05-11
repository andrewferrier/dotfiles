if [[ $TTY == "/dev/tty1" ]]; then
    if [[ $(hostname) == "lawn" ]]; then
        echo "Press a key to interrupt starting X..."
        IFS= read -k -t 1.5; RETVAL=$?
        if [ $RETVAL -ne 0 ]; then
            echo "Starting X..."
            exec startx
        fi
    fi
fi
