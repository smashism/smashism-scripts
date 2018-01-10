# smashism-scripts
general scripts for random things by or modified by smashism

### uninstall_office2016.sh
Uninstaller for the Office Suite, based on Microsoft's documentation and my own file discovery. Note that this script also includes removal of package receipts on both the OS level and for Jamf's own purposes. Replace the filenames for the Jamf receipts with whichever ones are relevant to your packages for deploying the apps. Also includes Lync, for those old timers that just don't remove old apps or refuse to let go of the past.

### warrantycheck.sh
Takes the EA by Andrew Thomson on JAMFNation and makes it into a script you can run from the terminal that prompts for information, then displays a result. For more immediate s/n status information, useful for auditing.
