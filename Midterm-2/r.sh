#Name: Jonathan Diep
#Cwid: 884973462
#Email: jonathon.dieppp@csu.fullerton.edu
#Date: Apr 23 2025
#Program: Final program.

echo "Assemble the source file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the source getqwords.asm"
nasm -f elf64 -l getqwords.lis -o getqwords.o getqwords.asm

echo "Compile the source file welcome.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -o main.o welcome.cpp

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o main.out getqwords.o manager.o main.o -std=c2x -Wall -z noexecstack -lm

echo "Execute the program"
chmod +x main.out
./main.out

echo "This bash script will now terminate."