rm -f.o
rm -f.out

echo "This program <Calculate_Triangle>


echo "Assemble the module calculate_triangle.asm"
nasm -f elf64 -l calculate_triangle.lis -o calculate_triangle.o calculate_triangle.asm

echo "Compile the C module geometry.c"
gcc  -m64 -Wall -no-pie -o geometry.o -std=c2x -c geometry.c

echo "Link the two object files already created"
gcc -m64 -no-pie -o calc.out calculate_triangle.o geometry.o -std=c2x -Wall -z noexecstack -lm

echo "Run the program Calculate_Triangle"
chmod +x calculate_triangle.out
./calculate_triangle.out