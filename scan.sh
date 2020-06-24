#!/bin/bash

if [ -z $1 ]
then
printf "\n\n"
echo "   ___              _      _       ___                           ";
echo "  |_ _|   _ _      (_)    | |_    / __|    __     __ _    _ _    ";
echo "   | |   | ' \     | |    |  _|   \__ \   / _|   / _\` |  | ' \   ";
echo "  |___|  |_||_|   _|_|_   _\__|   |___/   \__|_  \__,_|  |_||_|  ";
echo "_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"| ";
echo "\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-' ";
printf "\n\n\nUsage: ./scan.sh <ip>\n\n\n"

else
echo "   ___              _      _       ___                           ";
echo "  |_ _|   _ _      (_)    | |_    / __|    __     __ _    _ _    ";
echo "   | |   | ' \     | |    |  _|   \__ \   / _|   / _\` |  | ' \   ";
echo "  |___|  |_||_|   _|_|_   _\__|   |___/   \__|_  \__,_|  |_||_|  ";
echo "_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"|_|\"\"\"\"\"| ";
echo "\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-'\"\`-0-0-' ";

rm -rf $1
mkdir $1
printf "\nChecking to see if $1 is up\n\n";
	if nmap -sn $1| grep "Host is up"; then

#ping scan success - starting scan
	printf "\n\nPerforming all port scan on $1\n\n";
nmap -sS -sV -p- $1 | tee $1/all_ports_scan.txt;

		if cat $1/all_ports_scan.txt | grep "http " || cat $1/all_ports_scan.txt | grep "filtered https" ; then

#scan success - http ports present
		printf "\n\nStarting Dirb and Nikto scans on HTTP Ports\n\n";
cat $1/all_ports_scan.txt | grep "http " | cut -d "/" -f1 > $1/http_ports;
cat $1/all_ports_scan.txt | grep "filtered https" | cut -d "/" -f1 >> $1/http_ports;

ports=$(<./$1/http_ports);
python http_enum.py $1 $ports;

		else

#scan success - no http ports present
		printf "\n\nScan complete - no http ports present\n\n"
		fi

	else 

#ping scan fail
	printf "\n\nHost appears to be down.\n\nChecking connection\n\n"
	ifconfig

	fi
fi

