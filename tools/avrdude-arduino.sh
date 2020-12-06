#!/bin/sh

print_help()
{
  echo "$0 <board, ex: nano|uno|mega> <serial port, ex: /dev/ttyUSB0> <file name>"
}

if [ $# -ne 3 ]; then
  print_help
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
