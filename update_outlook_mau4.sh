#!/bin/bash

# DISCLAIMER:
# This script is not confirmed working. PRs welcome.
# Use at your own risk O_O

log() {
    echo "$1"
    /usr/bin/logger -t "Microsoft Outlook MAU4 Updater:" "$1"
}

loggedInUserPid=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; username = SCDynamicStoreCopyConsoleUser(None, None, None)[1]; print(username);')
launchctlCmd=$(python -c 'import platform; from distutils.version import StrictVersion as SV; print("asuser") if SV(platform.mac_ver()[0]) >= SV("10.10") else "bsexec"')

log "Writing LaunchAgent..."
read -d '' LaunchAgent <<"EOF"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>Label</key>
        <string>com.homedepot.outlookupdate</string>
        <key>ProgramArguments</key>
        <array>
                <string>msupdate</string>
                <string>--install</string>
                <string>--apps:OPIM15</string>
                <string>--terminate:1</string>
                <string>--message:'Please save and quit Outlook to install this update.'</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
</dict>
</plist>
EOF
echo "$LaunchAgent" > /Library/LaunchAgents/com.homedepot.outlookupdate.plist

/usr/sbin/chown root:wheel /Library/LaunchAgents/com.homedepot.outlookupdate.plist
/bin/chmod 644 /Library/LaunchAgents/com.homedepot.outlookupdate.plist

log "Loading LaunchAgent..."
/bin/launchctl "$launchctlCmd" "$loggedInUserPid" /bin/launchctl load /Library/LaunchAgents/com.homedepot.outlookupdate.plist
if [ $? -ne 0 ]; then
    log "launchctl error: The LaunchAgent failed to load"; exit 1
fi

#sleep 30
#log "Starting update with msupdate"

log "Cleaning up"
rm -Rf /Library/LaunchAgents/com.homedepot.outlookupdate.plist

exit 0
