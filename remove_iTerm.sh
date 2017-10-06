#!/bin/bash

# This program will remove the various iTerm app names to do a clean update

#################
### Variables ###
#################

# Items at the system level to be removed
systemItems=(
	/Applications/iTerm.app
	# Following .apps represent the variety of iTerm app names on THD machines based on a search -ek
    /Applications/iTerm\ 2.app
    /Applications/iTerm-2.app
    /Applications/iTerm\ 3.app
    /Applications/iTerm\ \(3.0.4\).app
    /Applications/iTerm\ \(3.0.9\).app
    /Applications/iTerm29.app
)


#################
### Functions ###
#################

function deleteItems()
{
	declare -a toDelete=("${!1}")

	for item in "${toDelete[@]}"
		do
			if [[ ! -z "${2}" ]]
				then
					item=("${2}""${item}")
			fi

			echo "Looking for $item"

			if [ -e "${item}" ]
				then
					echo "Removing $item"
					rm -rf "${item}"
			fi
		done
}

####################
### Main Program ###
####################

# Delete system level items
deleteItems systemItems[@]

exit 0
