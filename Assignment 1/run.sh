# /bin/bash

# Program name "Triangles"
# Author: Jonathan Diep
# Author Email: jonathon.dieppp@csu.fullerton.edu
# CWID: 884973462
# Class: 240-03 Section 03
# Date program began: 2024-Feb-06
# Date of last update: 2024-Feb-08
# This file is the script file that accompanies the "Triangles" program.
# Prepare for execution in normal mode (not gdb mode).

# Delete un-needed files
rm -f *.o
rm -f *.out

echo "Assembling the source file triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm

echo "Compiling the source file geometry.c"
gcc -m64 -Wall -no-pie -o geometry.o -std=c2x -c geometry.c

echo "Linking the object modules to create an executable file"
gcc -m64 -no-pie -o triangle.out triangle.o geometry.o -std=c2x -Wall -z noexecstack -lm

echo "Executing the program"
chmod +x triangle.out
./triangle.out

echo "This bash script will now terminate." 
