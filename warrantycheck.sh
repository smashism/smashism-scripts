#!/bin/sh

#	this script was written to query apple's service database to determine warranty coverage
#	base on a system's serial number. This updated version stores the infomration locally so
#	as not to have to query apple's website repeatedly.

#	author: 	Andrew Thomson
#	date:		5/30/2013

#   modified:   github.com/smashism
#   date:       6/30/2015

#   this modified script is meant for adhoc use to check serial numbers manually as needed
#   via prompt when run in a terminal of your choice.


#	set temp file
WarrantyTempFile="/tmp/warranty.$(date +%s).txt"


#	get serial number

echo "Please enter the serial number and press [ENTER}:"
read SerialNumber

#	query url
WarrantyURL="https://selfsolve.apple.com/wcResults.do?sn=${SerialNumber}&Continue=Continue&num=0"
WarrantyInfo=$(curl -k -s $WarrantyURL | awk '{gsub(/\",\"/,"\n");print}' | awk '{gsub(/\":\"/,":");print}' | sed s/\"\}\)// > ${WarrantyTempFile})


#	check validity of serial number
InvalidSerial=$(grep 'invalidserialnumber\|productdoesnotexist' "${WarrantyTempFile}")
if [[ -n "${InvalidSerial}" ]]; then
echo "Invalid Serial Number."
exit 2
fi


#	determine warranty status
WarrantyStatus=$(grep displayHWSupportInfo "${WarrantyTempFile}")
if [[ $WarrantyStatus =~ "Active" ]]; then
WarrantyStatus="Active"
else
WarrantyStatus="Inactive"
fi


#	check for exirpation date
if [[ `grep displayHWSupportInfo "${WarrantyTempFile}"` ]]; then
WarrantyDate=`grep displayHWSupportInfo "${WarrantyTempFile}" | grep -i "Estimated Expiration Date:"| awk -F'<br/>' '{print $2}'|awk '{print $4,$5,$6}'`
fi


#	convert format of date
if [[ -n "$WarrantyDate" ]]; then
WarrantyDate=$(/bin/date -jf "%B %d, %Y" "${WarrantyDate}" +"%Y-%m-%d") > /dev/null 2>&1
else
WarrantyDate="N/A"
fi


#	write status and date to plist (if you have this as an EA in your JSS then this step will
#   error out on your machine because it won't over-write your com.apple.warranty

# if [[ -n "$WarrantyStatus" ]] && [[ -n "$WarrantyDate" ]]; then
# /usr/bin/defaults write /Library/Preferences/com.apple.warranty WarrantyStatus ${WarrantyStatus}
# /usr/bin/defaults write /Library/Preferences/com.apple.warranty WarrantyDate ${WarrantyDate}
# fi


echo Serial Number: "${SerialNumber}"
echo Warranty Status: ${WarrantyStatus}
echo Warranty Expiration: ${WarrantyDate}

echo "<result>${WarrantyStatus} : ${WarrantyDate}</result>"
