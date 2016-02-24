###############################################################################
# Makefile for the project midi-conv
###############################################################################

## General Flags
PROJECT = MIDI-CONV

MCU = attiny4313

CLK = 16000000UL
#CLK = 12000000UL
#CLK = 16000000UL
#CLK = 20000000UL

TARGET = micomoco.elf

#
# CAUTION: You must use gcc3. With gcc4, the object code will grow >2k.
#
CC = avr-gcc
AVRDUDE = avrdude -c usbtiny -p$(MCU)

FUSEH = 0xcf
FUSEL = 0xef
# Fuse high byte:
# 0xcf = 1 1 0 0   1 1 1 1 <-- RSTDISB (External Reset disable)
#        ^ ^ ^ ^   ^ ^ ^------ BODLEVEL0
#        | | | |   | +-------- BODLEVEL1
#        | | | |   + --------- BODLEVEL2
#        | | | +-------------- WDTON (WDT not always on)
#        | | +---------------- SPIEN (allow serial programming)
#        | +------------------ EESAVE (preserve EEPROM over chip erase)
#        +-------------------- DWEN (debugWIRE Enable)
# Fuse low byte:
# 0xef = 1 1 1 0   1 1 1 1
#        ^ ^ \ /   \--+--/
#        | |  |       +------- CKSEL 3..0 (external >8M crystal)
#        | |  +--------------- SUT 1..0 (crystal osc, BOD enabled)
#        | +------------------ CKOUT (1 = diable)
#        +-------------------- CKDEV8 (CLOCK DEV by 8)

## Options common to compile, link and assembly rules
COMMON = -g -mmcu=$(MCU) -DF_CPU=$(CLK)

## Compile options common for all C compilation units.
#for gcc-3
CFLAGS = $(COMMON)
CFLAGS += -Wall  -Os -fsigned-char  $(DEBUG)

## Assembly specific flags
# for gcc-3
ASMFLAGS = $(COMMON)
ASMFLAGS += $(CFLAGS)
ASMFLAGS += -x assembler-with-cpp -Wa,-gdwarf2

## Linker flags
LDFLAGS = $(COMMON)
LDFLAGS += 


## Intel Hex file production flags
HEX_FLASH_FLAGS = -R .eeprom -R .fuse -R .lock -R .signature

HEX_EEPROM_FLAGS = -j .eeprom
HEX_EEPROM_FLAGS += --set-section-flags=.eeprom="alloc,load"
HEX_EEPROM_FLAGS += --change-section-lma .eeprom=0 --no-change-warnings


## Include Directories
INCLUDES =  -I. -I"../usbdrv" 

## Objects that must be built in order to link
OBJECTCOMMON = usbdrv.o usbdrvasm.o oddebug.o 
OBJECTS = micomoco.o $(OBJECTCOMMON)

## Objects explicitly added by the user
LINKONLYOBJECTS = 

## Build
all: $(TARGET) micomoco.hex micomoco.eep micomoco.lss size

## Compile
usbdrvasm.o: ../usbdrv/usbdrvasm.S
	$(CC) $(INCLUDES) $(ASMFLAGS) -c  $<

main.o: main.c
	$(CC) $(INCLUDES) $(CFLAGS) -c  $<

usbdrv.o: ../usbdrv/usbdrv.c
	$(CC) $(INCLUDES) $(CFLAGS) -c  $<

oddebug.o: ../usbdrv/oddebug.c
	$(CC) $(INCLUDES) $(CFLAGS) -c  $<

micomoco.o : ../main.c
	$(CC) $(INCLUDES) $(CFLAGS) -DRECEIVER -DTRANSMITTER -o micomoco.o -c $<

##Link
$(TARGET): $(OBJECTS)
	 $(CC) $(LDFLAGS) $(OBJECTS) $(LINKONLYOBJECTS) $(LIBDIRS) $(LIBS) -o $(TARGET)

%.hex: %.elf
	avr-objcopy -O ihex $(HEX_FLASH_FLAGS)  $< $@

%.eep: %.elf
	-avr-objcopy $(HEX_EEPROM_FLAGS) -O ihex $< $@ || exit 0

%.lss: %.elf
	avr-objdump -h -S $< > $@

size: ${TARGET}
	@echo TARGET = ${TARGET}
	@avr-size -C --mcu=${MCU} ${TARGET}


## Clean target
.PHONY: clean
clean:
	-rm -rf $(OBJECTS) *.elf dep/* *.hex *.eep *.lss

## Other dependencies
#-include $(shell mkdir dep 2>/dev/null) $(wildcard dep/*)

.PHONY: flash
flash:	all
	$(AVRDUDE) -U flash:w:micomoco.hex -U eeprom:w:micomoco.eep

.PHONY: fuse
fuse:
	$(AVRDUDE) -U hfuse:w:$(FUSEH):m -U lfuse:w:$(FUSEL):m
