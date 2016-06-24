#!/bin/bash

# Determine working directory

install_dir=$(dirname "$0")

# Run primary app installers

/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_Word_2016_15.23.0_160611_Installer.pkg" -target "$3"
/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_Excel_2016_15.23.0_160611_Installer.pkg" -target "$3"
/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_PowerPoint_2016_15.23.0_160611_Installer.pkg" -target "$3"

# Run individual Update pkgs

/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_Word_15.23.1_160617_Updater.pkg" -target "$3"
/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_Excel_15.23.1_160617_Updater.pkg" -target "$3"

# Why not Zoidberg?

exit 0
