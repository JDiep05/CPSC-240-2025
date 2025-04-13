rm *.o
rm *.out

echo "Assemble the source file faraday.asm"
nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm

echo "Assemble the source file edison.asm"
nasm -f elf64 -l edison.lis -o edison.o edison.asm

echo "Assemble the source file tesla.asm"
nasm -f elf64 -l tesla.lis -o tesla.o tesla.asm

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o main.out faraday.o edison.o tesla.o

echo "Execute the program"
chmod +x main.out
./main.out

echo "This bash script will now terminate."