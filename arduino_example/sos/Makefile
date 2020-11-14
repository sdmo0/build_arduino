ARDUINO_DIR=/usr/share/arduino
CORES=$(ARDUINO_DIR)/hardware/arduino/cores/arduino
STDVARIANT=$(ARDUINO_DIR)/hardware/arduino/variants/standard
AVRD_CONF=$(ARDUINO_DIR)/hardware/tools/avrdude.conf

MMU=atmega328p
CPUCLOCK=16000000L
ARDUINOVER=101
SERIALPORT=/dev/ttyACM0
BAUDRATE=115200

CODENAME=mycode

GC_HWOPTS=-mmcu=$(MMU) -DF_CPU=$(CPUCLOCK) -DARDUINO=$(ARDUINOVER)
GC_STDINC=-I$(CORES) -I$(STDVARIANT)
GPP_OPTS=-c -g -Os -Wall -fno-exceptions -ffunction-sections -fdata-sections $(GC_HWOPTS) $(GC_STDINC)
GCC_OPTS=-c -g -Os -Wall -ffunction-sections -fdata-sections $(GC_HWOPTS) $(GC_STDINC)
GCC_LINKOPTS=-mmcu=$(MMU) -Wl,--gc-sections -L. -lm -lcore
OBJCPY_EEPOPTS=-O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0
OBJCPY_HEXOPTS=-O ihex -j .text -j .data -R .eeprom
AVRD_OPTS=-C$(AVRD_CONF) -p$(MMU) -carduino -P$(SERIALPORT) -b$(BAUDRATE) -D -Uflash:w:./$(CODENAME).hex:i

build:
	avr-g++ $(GPP_OPTS) -o$(CODENAME).o $(CODENAME).cpp
	avr-gcc $(GCC_OPTS) -owiring_analog.o $(CORES)/wiring_analog.c
	avr-gcc $(GCC_OPTS) -owiring_digital.o $(CORES)/wiring_digital.c
	avr-gcc $(GCC_OPTS) -owiring_pulse.o $(CORES)/wiring_pulse.c
	avr-gcc $(GCC_OPTS) -owiring_shift.o $(CORES)/wiring_shift.c
	avr-gcc $(GCC_OPTS) -owiring.o $(CORES)/wiring.c
	avr-gcc $(GCC_OPTS) -oWInterrupts.o $(CORES)/WInterrupts.c
	avr-g++ $(GPP_OPTS) -oCDC.o $(CORES)/CDC.cpp
	avr-g++ $(GPP_OPTS) -oHardwareSerial.o $(CORES)/HardwareSerial.cpp
	avr-g++ $(GPP_OPTS) -oHID.o $(CORES)/HID.cpp
	avr-g++ $(GPP_OPTS) -oIPAddress.o $(CORES)/IPAddress.cpp
#	avr-g++ $(GPP_OPTS) -omain.o $(CORES)/main.cpp
	avr-g++ $(GPP_OPTS) -onew.o $(CORES)/new.cpp
	avr-g++ $(GPP_OPTS) -oPrint.o $(CORES)/Print.cpp
	avr-g++ $(GPP_OPTS) -oStream.o $(CORES)/Stream.cpp
	avr-g++ $(GPP_OPTS) -oTone.o $(CORES)/Tone.cpp
	avr-g++ $(GPP_OPTS) -oUSBCore.o $(CORES)/USBCore.cpp
	avr-ar rcs ./libcore.a ./wiring_analog.o
	avr-ar rcs ./libcore.a ./wiring_digital.o
	avr-ar rcs ./libcore.a ./wiring_pulse.o
	avr-ar rcs ./libcore.a ./wiring_shift.o
	avr-ar rcs ./libcore.a ./wiring.o
	avr-ar rcs ./libcore.a ./WInterrupts.o
	avr-ar rcs ./libcore.a ./CDC.o
	avr-ar rcs ./libcore.a ./HardwareSerial.o
	avr-ar rcs ./libcore.a ./HID.o
	avr-ar rcs ./libcore.a ./IPAddress.o
#	avr-ar rcs ./libcore.a ./main.o
	avr-ar rcs ./libcore.a ./new.o
	avr-ar rcs ./libcore.a ./Print.o
	avr-ar rcs ./libcore.a ./Stream.o
	avr-ar rcs ./libcore.a ./Tone.o
	avr-ar rcs ./libcore.a ./USBCore.o
	avr-ar rcs ./libcore.a ./WString.o
	avr-ar rcs ./libcore.a ./WMath.o
	avr-gcc -o$(CODENAME).elf $(CODENAME).o $(GCC_LINKOPTS)
	avr-objcopy $(OBJCPY_EEPOPTS) $(CODENAME).elf $(CODENAME).eep
	avr-objcopy $(OBJCPY_HEXOPTS) $(CODENAME).elf $(CODENAME).hex

flash:
	avrdude $(AVRD_OPTS)

clean:
	-rm -f *.o *.hex *.eep libcore.a *~
