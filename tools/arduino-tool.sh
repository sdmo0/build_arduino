#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. ${DIR}/file-tools.sh

print_help()
{
  filename=$(get_file_name_ext $0)
  echo "${filename} <command, init|build|upload> <board, nano|uno|mega> <ino file name> <serial port, /dev/ttyUSB0>"
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

# $1 = parameter number
# $2 = valid min number
# $3 = valid max number
check_parameter_number()
{
  if [ $1 -lt $2 ] || [ $1 -gt $3 ]; then
    print_help
    echo "-----------------------------"
    echo "the number of parameter is not proper to this command"
    exit
  fi
}

check_parameter_1()
{
  if [ $1 != "build" ] && [ $1 != "upload" ] && [ $1 != "init" ]; then
    print_help
    echo "-----------------------------"
    echo "first parameter: only use 'init', 'build', or 'upload'"
    exit
  fi
}

check_parameter_2()
{
  if [ "$1" != "nano" ] && [ "$1" != "uno" ] && [ "$1" != "mega" ]; then
    print_help
    echo "-----------------------------"
    echo "second parameter: only use 'nano', 'uno' or 'mega'"
    exit
  fi
}

argc=$#
check_parameter_1 $1

if [ $1 == "init" ]; then
  check_parameter_number $argc 1 1
  arduino-cli core install arduino:avr   

elif [ $1 == "build" ]; then
  check_parameter_2 $2
  check_parameter_number $argc 3 3
  echo "building for arduino $2 ..."
  print_parameter $1 $2 $3 $4
  arduino-cli compile --fqbn arduino:avr:$2 $3 $4

elif [ $1 == "upload" ]; then
  check_parameter_2 $2
  check_parameter_number $argc 4 4
  echo "uploading to arduino $2 ..."
  print_parameter $1 $2 $3 $4
  arduino-cli $1 -v -p $4 -b arduino:avr:$2 $3
  # arduino-cli upload -v -p /dev/ttyUSB0 -b arduino:avr:nano:cpu=atmega328old my_sketch/

else
  print_help $0
  exit
fi
