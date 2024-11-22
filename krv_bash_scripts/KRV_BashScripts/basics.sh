#!/bin/bash

# Importing Various KRV BASH functions 

if [ -f "./krv_bash_lib.sh" ]; then
	source ./krv_bash_lib.sh
else
	echo "krv_bash_lib not found!"
	exit 1
fi

KRV_FileLog_Enable
KRV_Welcome


dir_name="_build"

if [ -d $dir_name ]; then 
	log_message "error" "_build directory exists"	
else
	echo "(INFO)_build folder does not exist"
	echo "(INFO)creating _build folder"
	mkdir _build
fi
