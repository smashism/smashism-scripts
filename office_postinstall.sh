#!/bin/bash

# Determine working directory

install_dir=$(dirname "$0")

# Run primary installer with choices file

/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_Office_2016_15.23.0_160611_Volume_Installer.pkg" -target "$3" -applyChoiceChangesXML "$install_dir/choices.plist"

# Run individual Update pkgs

/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_Word_15.24.0_160709_Updater.pkg" -target "$3"
/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_Excel_15.24.0_160709_Updater.pkg" -target "$3"
/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Microsoft_PowerPoint_15.24.0_160709_Updater.pkg" -target "$3"

# Why not Zoidberg?

exit 0
