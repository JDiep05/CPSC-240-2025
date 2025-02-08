#/bin/bash

#Program name "Triangles"
#Author: Kaitlyn Lee
#Author Email: kaitlynlee@csu.fullerton.edu
#CWID: 886374479
#Class: 240-03 Section 03
#This file is the script file that accompanies the "Triangles" program.
#Prepare for execution in normal mode (not gdb mode).

rm -f *.o
rm -f *.out

echo "Assembling the source file calculate_triangle.asm"
nasm -f elf64 -l calculate_triangle.lis -o calculate_triangle.o calculate_triangle.asm

echo "Compiling the source file geometry.c"
gcc -m64 -Wall -no-pie -o geometry.o -std=c2x -c geometry.c

echo "Linking the object modules to create an executable file"
gcc -m64 -no-pie -o triangle.out calculate_triangle.o geometry.o -std=c2x -Wall -z noexecstack -lm

echo "Executing the program"
chmod +x triangle.out
./triangle.out

echo "This bash script will now terminate." 
