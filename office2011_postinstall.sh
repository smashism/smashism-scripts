#!/bin/sh

# original postinstall.sh by rtrouton
# more info at: http://bit.ly/1GjQiKE
# modified to add Lync updater by smashism 2015-06-18

# Determine working directory

install_dir=`dirname $0`

# Location of Microsoft Office Volume License file

office_license="$3/Library/Preferences/com.microsoft.office.licensing.plist"

# Backup location for Microsoft Office 2011 Volume License file

license_backup="$3/tmp/com.microsoft.office.licensing.plist"

/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Office Installer.pkg" -target "$3"

# Copy a backup of the Microsoft Office 2011 Volume License file to /tmp. If the license file is
# not available as /Library/Preferences/com.microsoft.office.licensing.plist,  restore from the
# backup license file included  with this installer.

if [[ -f "$office_license" ]]; then
cp "$office_license" "$license_backup"
fi

if [[ ! -f "$office_license" ]]; then
cp "$install_dir/com.microsoft.office.licensing.plist" "$license_backup"
fi

/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Office 2011 14.5.2 Update.pkg" -target "$3"

/usr/sbin/installer -dumplog -verbose -pkg "$install_dir/Lync Installer 14.0.11.pkg" -target "$3"

# If the Microsoft Office 2011 Volume License file has been removed from its proper
# location, restore it using the backup file stored in /tmp and then set the correct
# permissions on the file. If it is not available in /tmp, restore from the backup included
# with this installer.

if [[ ! -f "$office_license" ]] && [[ -f "$license_backup" ]]; then
cp "$license_backup" "$office_license"
chown root:wheel "$office_license"
fi

# Remove the backup file from /tmp

if [[ -f "$license_backup" ]]; then
rm "$license_backup"
fi


exit 0
