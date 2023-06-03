if [[ $TTY == "/dev/tty1" ]]; then
    if type X >/dev/null 2>/dev/null; then
        echo "Press a key to interrupt starting X..."
        IFS= read -k -t 1.5; RETVAL=$?
        if [ $RETVAL -ne 0 ]; then
            echo "Starting X..."
            exec startx
        fi
    fi
fi
