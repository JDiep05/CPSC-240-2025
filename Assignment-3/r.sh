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