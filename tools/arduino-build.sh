#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. ${DIR}/file-tools.sh

print_help()
{
  filename=$(get_file_name_ext $1)
  echo "${filename} <command, compile|upload> <board, nano|uno|mega> <ino file name> <serial port, /dev/ttyUSB0>"
}

print_parameter()
{
  echo "------------------------------------------------------------"
  echo "command: $1"
  echo "Arduino Board type: $2"
  echo "File name to be processed: $3"
  echo "Serial Port in upload: $4"
  echo "------------------------------------------------------------"
}

argc=$#
if [ $argc -lt 3 ] || [ $argc -gt 4 ]; then
  print_help $0
  exit
fi

if [ "$1" != "compile" ] && [ "$1" != "upload" ]; then
  print_help $0
  echo "-----------------------------"
  echo "first parameter: only use 'compile' or 'upload'"
  exit
fi

if [ "$2" != "nano" ] && [ "$2" != "uno" ] && [ "$2" != "mega" ]; then
  print_help $0
  echo "-----------------------------"
  echo "second parameter: only use 'nano', 'uno' or 'mega'"
  exit
fi


if [ $1 == "compile" ]; then
  
  echo "building for arduino $2 ..."
  print_parameter $1 $2 $3 $4
  arduino-cli $1 --fqbn arduino:avr:$2 $3 $4

elif [ $1 == "upload" ]; then
  
  echo "uploading to arduino $2 ..."
  print_parameter $1 $2 $3 $4
  arduino-cli $1 -v -p $4 -b arduino:avr:$2 $3
  # arduino-cli upload -v -p /dev/ttyUSB0 -b arduino:avr:nano:cpu=atmega328old my_sketch/

else
  print_help $0
  exit
fi
