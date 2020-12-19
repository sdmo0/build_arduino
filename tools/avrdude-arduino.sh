#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. ${DIR}/file-tools.sh

print_help()
{
  filename=$(get_file_name_ext $1)
  echo "${filename} <board, ex: nano|uno|mega> <serial port, ex: /dev/ttyUSB0> <file name>"
}

if [ $# -ne 3 ]; then
  print_help $0
  exit
fi

if [ $1 = "nano" ]; then
  echo "uploading to $1 board..."
  avrdude -v -c arduino -p m328p -P $2 -b 115200 -Uflash:w:$3:i

elif [ $1 = "uno" ]; then
  echo "uploading to $1 board..."
  avrdude -v -c arduino -p m328p -P $2 -b 115200 -Uflash:w:$3:i

elif [ $1 = "mega" ]; then
  echo "uploading to $1 board..."
  avrdude -v -c wiring -p m2560 -P $2 -b 115200 -Uflash:w:$3:i

else
  print_help
fi
