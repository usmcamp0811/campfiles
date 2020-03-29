#!/bin/sh

# This will set the locale properly and allow you to make gnome-terminal work
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen

echo "Fixed /etc/locale.gen"

echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "LC_MESSAGES=en_US.UTF-8" >> /etc/locale.conf

echo "Fixed /etc/locale.conf"

echo "KEYMAP=us" > /etc/vconsole.conf

echo "Created /etc/vconsole.conf"

locale-gen
