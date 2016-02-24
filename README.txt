Simple USB-MIDI Converter
MOCO (MIDI Output COnverter) / MICO (MIDI Input COnverter)

2010/08/22

morecat_lab 
http://web.mac.com/kuwatay/

1. Hardware

 Becuase of the ristrictions of flash memory size in Tiny2313, you can
 build a device which work one way; USB-> MIDI (MOCO) or MIDI -> USB
 (MICO).

 You need a Tiny2313 for MOCO or MICO. If you build MICO, a
 opt-coupler should be installed to full fill the requirement of MIDI.
 A 16MHz Christal OSC and level converter circuit for V-USB should
 prepared for both MOCO and MICO.

2. Compile
 Just type 'make' in firmware directory. Makefiles will take care the
 rest of the job.  You must use gcc 3.5 for compile the source code.
 The object files are build under moco/ and mico/

3. Burn tiny2313

 Follow the instructions of your avr programmer.
 Fuse bits should be as follows;

FUSEH = 0xcf
FUSEL = 0xef

4. Host driver

 No driver software is required for Windows, MacOSX, and Linux. MICO
 and MOCO were tested only on MacOSX.

Enjoy.


