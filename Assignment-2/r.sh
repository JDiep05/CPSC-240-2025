rm *.o
rm *.out

echo "Assembling manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assembling input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assembling output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Assembling sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assembling swap.asm"
nasm -f elf64 -l swap.lis -o swap.o swap.asm

echo "Assembling isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compiling main.c"
gcc -c -m64 -Wall -no-pie -o main.o main.c -std=c2x

echo "Compiling sort.c"
gcc -c -m64 -Wall -no-pie -o sort.o sort.c -std=c2x

echo "Linking object files"
gcc -m64 -no-pie -o main.out main.o manager.o input_array.o output_array.o sum.o swap.o sort.o isfloat.o -std=c2x -Wall -z noexecstack

echo "Running program"
chmod +x main.out
./main.out

echo "Script terminated"