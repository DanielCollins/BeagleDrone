BeagleDrone
==============

An Open Source drone based on the BeagleBone.

## Why

Robotics projects, specifically drones, often need far more memory than a
typical microcontroller can offer. This is often solved by using a second
computer running a full modern operating system (such as linux). This causes a
massive gain in complexity in both hardware in software.

An alternative solution is to develop the drone control code on a powerful
enough platform that only one computer is needed. This is generally avoided
due to the difficulty of building up a code base for modern powerful computers.

The BeagleDrone is a drone built using the BeagleBone, a 720Mhz ARM with 256MB
of RAM and plenty of peripherals. This allows for modern state estimation and
other algorithms to be used without the need for a second computer, or second
code base.

# Firmware

The firmware directory contains the code which runs on the beagleboard.

## Dependencies

You require make and an gcc eabi arm cross compiler toolchain to build this
project. Although any method of obtaining the arm-eabi will work equally well,
below are the recommended methods for obtaining the toolchain.

### OS X

I have used jsnyder's ARM EABI Toolchain Builder to great success, it is very
easy to install by following the guide in his github repository:

http://github.com/jsnyder/arm-eabi-toolchain

### Linux

I have not tested jsnyder's toolchain on Linux but it claims to work there as
well. On Linux I tend to use esden's summon-arm-toolchain package:

http://github.com/esden/summon-arm-toolchain


## Building

To build the package make sure the arm-none-eabi-\* tools are in your PATH.

Running the command `make` will create a boot.bin, suitable for flashing


## Flashing

I have yet to find a pleasant method for flashing. Currently, I use an SD card
with U-Boot (comes on standard beaglebone linux image). I run the `loady`
command at the U-Boot prompt, and use yterminal protocol (via minicom) to
send the boot.bin. I then execute `go 0x82000000` to run the binary.

## Testing

Run the command

`make test`

# Client

The client is run on a PC and can be used to communicated with the drone.

## Dependencies

Qt5, g++ and CMake are required to build and run the client;

## Building

To build the client run the following commands

`cd client; cmake .; make`
