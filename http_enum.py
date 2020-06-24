#!/usr/bin/env python
import sys
import subprocess

arguments = len(sys.argv)
for x in range(2, arguments):

	if sys.argv[x] != "443":
		f = open(sys.argv[1] + "/" + sys.argv[x] + "nikto.txt","w")
		subprocess.Popen(["nikto", "-host", "http://" + sys.argv[1] + ":" + sys.argv[x]], stdout=f)
		subprocess.Popen(["dirb", "http://" + sys.argv[1] + ":" + sys.argv[x], "-r", "-o", sys.argv[1] + "/" + sys.argv[x] + "dirb.txt"])
		
	elif sys.argv[x] == "443":
		subprocess.Popen(["dirb", "https://" + sys.argv[1], "-r", "-o", sys.argv[1] + "/" + sys.argv[x] + "dirb.txt"])
		f = open(sys.argv[1] + "/" + sys.argv[x] + "nikto.txt","w")
		subprocess.Popen(["nikto", "-host", "https://" + sys.argv[1]], stdout=f)
		
