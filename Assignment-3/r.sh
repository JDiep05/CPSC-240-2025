#/bin/bash

# Program name "Huron's Triangle"
# Author: Jonathan Diep
# Author Email: jonathon.dieppp@csu.fullerton.edu
# CWID: 884973462
# Class: 240-03 Section 03
# Date program began: 2024-Mar-03
# Date of last update: 2024-Mar-08
# This file is the script file that accompanies the "Huron's Triangle" program.
# Prepare for execution in normal mode (not gdb mode).


rm *.o
rm *.out

echo "Assembling manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assembling isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Assembling istriangle.asm"
nasm -f elf64 -l istriangle.lis -o istriangle.o istriangle.asm

echo "Assembling huron.asm"
nasm -f elf64 -l huron.lis -o huron.o huron.asm

echo "Assembling triangle.c"
gcc -c -m64 -Wall -no-pie -o triangle.o triangle.c -std=c2x

echo "Linking object files"
gcc -m64 -no-pie -o triangle.out triangle.o manager.o isfloat.o istriangle.o huron.o

echo "Running program"
chmod +x triangle.out
./triangle.out