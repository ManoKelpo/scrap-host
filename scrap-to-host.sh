#!/usr/bin/env bash
#
#Parsing.sh
#Ver 1.0
#
#This tool scraps URLs within an website that the user inputs, then translate them to their IP addresses.
#
#

# Checks if the argument is empty
if [ $# -eq 0 ]
then
	echo "Error: no argument supplied"
	echo "Please provide an url"
	echo "Example: parsing www.site.com"
	exit 1
fi

# Parses the hrefs within the website
links=$(curl "$1" | grep -o 'href="http.*/' | cut -d '"' -f2 | cut -d "/" -f3 | sort | uniq)

# Hosts=("www.google.com" "www.businesscorp.com.br" "www.terra.com.br")
host $1

# Colors
YELLOW="\e[33m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

# Search the host IP address for each link within the list.
for i in ${links[@]}; do
	echo -e "${YELLOW}Searching host for ($i):${ENDCOLOR}"
	host "$i" | cut -d " " -f2,3-
	sleep 0.50 
	echo ""
done
