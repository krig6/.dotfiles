#!/bin/bash

. /etc/X11/xinit/xinitrc
export XDG_SESSION_TYPE=x11
exec openbox-session
