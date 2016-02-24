###############################################################################
# Makefile for the project AVR-MIDI
###############################################################################

TARGET = ALL

all : moco/moco.hex mico/mico.hex micomoco/micomoco.hex

moco/moco.hex: main.c
	avr-gcc-select 3
	cd moco ; make

mico/mico.hex: main.c
	avr-gcc-select 3
	cd mico ; make

micomoco/micomoco.hex: main.c
	avr-gcc-select 4
	cd micomoco ; make

copy: moco/moco.hex mico/mico.hex
	cp moco/moco.hex HEX/moco.hex
	cp moco/moco.eep HEX/moco.eep
	cp mico/mico.hex HEX/mico.hex
	cp mico/mico.eep HEX/mico.eep
	cp micomoco/micomoco.hex HEX/micomoco.hex
	cp micomoco/micomoco.eep HEX/micomoco.eep

clean:
	-rm *~
	( cd moco ; make clean)
	( cd mico ; make clean)
	( cd micomoco ; make clean)
