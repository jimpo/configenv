#!/bin/sh

# Capslock as meta remapping option
cd /usr/share/X11/xkb/rules
sudo sed -i 's/^  caps:menu\t\t=\t+capslock(menu)$/  caps:meta\t\t=\t+capslock(meta)\n\0/' base
sudo sed -i 's/^  caps:menu\( \+\)Make Caps Lock an additional Menu key$/  caps:meta\1Make Caps Lock an additional Meta key\n\0/' base.lst
sudo sed -i 's/^  caps:menu\t\t=\t+capslock(menu)$/  caps:meta\t\t=\t+capslock(meta)\n\0/' evdev
sudo sed -i 's/^  caps:menu\( \+\)Make Caps Lock an additional Menu key$/  caps:meta\1Make Caps Lock an additional Meta key\n\0/' evdev.lst

