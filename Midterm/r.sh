#/bin/bash

# Program name "Harmonic Mean"
# Author: Jonathan Diep
# Author Email: jonathon.dieppp@csu.fullerton.edu
# CWID: 884973462
# Class: 240-03 Section 03
# Date program began: 2024-Mar-10
# Date of last update: 2024-Mar-10
# This file is the script file that accompanies the "Harmonic Mean" program.
# Prepare for execution in normal mode (not gdb mode).

# Delete un-needed files
rm *.o
rm *.out

echo "Assembling manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assembling input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assembling output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Assembling sum_reciprocals.asm"
nasm -f elf64 -l sum_reciprocals.lis -o sum_reciprocals.o sum_reciprocals.asm

echo "Compiling driver.c"
gcc -c -m64 -Wall -no-pie -o driver.o driver.c -std=c2x

echo "Linking object files"
gcc -m64 -no-pie -o driver.out driver.o manager.o input_array.o output_array.o sum_reciprocals.o

echo "Running program"
chmod +x driver.out
./driver.out

echo "Script terminated"