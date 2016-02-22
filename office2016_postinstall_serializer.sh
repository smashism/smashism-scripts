#!/bin/bash

# Determine working directory

install_dir=`dirname $0`

# Run primary VL installer for suite

/usr/sbin/installer -dumplog -verbose -pkg $install_dir/"Microsoft_Office_2016_Volume_Installer.pkg" -target "$3"

# Run Individual Update pkgs not included in VL installer

/usr/sbin/installer -dumplog -verbose -pkg $install_dir/"Microsoft_Word_15.17.1_Updater.pkg" -target "$3"
/usr/sbin/installer -dumplog -verbose -pkg $install_dir/"Microsoft_Outlook_15.17.1_Updater.pkg" -target "$3"

# Run VL Serializer pkg

/usr/sbin/installer -dumplog -verbose -pkg $install_dir/"Microsoft_Office_2016_VL_Serializer.pkg" -target "$3"

exit 0
