#/bin/bash

# Program name "Non-deterministic random numbers"
# Author: Jonathan Diep
# Author Email: jonathon.dieppp@csu.fullerton.edu
# CWID: 884973462
# Class: 240-03 Section 03
# Date program began: 2025-Mar-25
# Date of last update: 2025-Mar-27
# This file is the script file that accompanies the "" program.
# Prepare for execution in normal mode (not gdb mode).


rm *.o
rm *.out

echo "Assembling executive.asm"
nasm -f elf64 -l executive.lis -o executive.o executive.asm

echo "Assembling fill_random_array.asm"
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

echo "Assembling normalize_array.asm"
nasm -f elf64 -l normalize_array.lis -o normalize_array.o normalize_array.asm

echo "Assembling isnan.asm"
nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm

echo "Assembling show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

echo "Assembling sort.c"
gcc -c -m64 -Wall -no-pie -o sort.o sort.c -std=c2x

echo "Assembling main.c"
gcc -c -m64 -Wall -no-pie -o main.o main.c -std=c2x

echo "Linking object files"
gcc -m64 -no-pie -o main.out main.o executive.o fill_random_array.o isnan.o normalize_array.o show_array.o sort.o

echo "Running program"
chmod +x main.out
./main.out