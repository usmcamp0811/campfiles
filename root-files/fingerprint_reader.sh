#!/bin/sh

UP_DOWN=$1

if [ "$UP_DOWN" == "down" ]; then
    echo "Disabling Fingerprint Reader"
    echo "1-7" | sudo tee /sys/bus/usb/drivers/usb/unbind 
else
    echo "Enabling Fingerprint Reader"
    echo "1-7" | sudo tee /sys/bus/usb/drivers/usb/bind
fi

