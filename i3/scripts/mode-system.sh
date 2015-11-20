#!/bin/sh

#TODO lockscreen doesn't match login screen.
lock_screen() {
    gnome-screensaver-command --lock
}

# $1 - the new state you would like to enter.
change_power_state () {
    command_prefix="dbus-send --system --print-reply --dest=org.freedesktop.login1 \
               /org/freedesktop/login1 \"org.freedesktop.login1.Manager."
    command_suffix="\" boolean:true"

    eval ${command_prefix}${1}${command_suffix}
}

case "$1" in
    lock)
        lock_screen
        ;;
    logout)
        i3-msg exit
        ;;
    hibernate) # Go to sleep.
        lock_screen
        change_power_state "Hibernate"
        ;;
    suspend) # Store system state and power off.
        lock_screen
        change_power_state "Suspend"
        ;;
    reboot)
        change_power_state "Reboot"
        ;;
    poweroff)
        change_power_state "PowerOff"
        ;;
    *)
        echo "Usage: $0 {lock|logout|hibernate|suspend|reboot|shutdown}"
        exit 1
esac

exit 0
