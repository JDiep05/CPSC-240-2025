// *******************************************************************************************************************************
//  Program name: "Arrays of Floating Point Numbers". This program takes user input's of floating point number and place them into an array.
//  Copyright (C) 2025  Jonthan Diep                                                                                             *
//                                                                                                                               *
//  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License    *
//  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.        *
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty  *
//  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.                *
//  You should have received a copy of the GNU General Public License along with this program.  If not, see                      *
//  <https://www.gnu.org/licenses/>.                                                                                             *
// *******************************************************************************************************************************



//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
// Author: Jonathan Diep
// Author email: jonathon.dieppp@csu.fullerton.edu
// CWID: 884973462
// Class: 240-03 Section 03
// Program name: Arrays of Floating Point Numbers
// Programming languages: Two module in C, Six in X86, and One in bash.
// Date program began: 2024-Feb-22
// Date of last update: 2024-Feb-22
// Files in this program: main.c, manager.asm, input_array.asm, output_array.asm, sum.asm, sort.asm, swap.asm, isfloat.asm, run.sh.
// Testing: Alpha testing completed.  All functions are correct.
// Status: Ready for release to the customers

// Purpose of this program:
//  This program calculates for the third side of a triangle based on the user's input for the other two sides and the angle between them
// This file:
//  File name: main.c
//  Language: C language
//  Max page width: 124 columns
//  Compile: gcc -m64 -Wall -no-pie -o geometry.o -std=c2x -c geometry.c
//  Link: gcc -m64 -no-pie -o triangle.out calculate_triangle.o geometry.o -std=c2x -Wall -z noexecstack -lm
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern double manager();

int main(void) {
    printf("\nWelcome to Arrays of floating point numbers.\n");
    printf("Bought to you by Jonathan Diep\n\n");

    double output = manager();

    printf("\n\nMain recieved %.10lf, and will keep it for future use.\n", output);
    printf("Main will return 0 to the operating system. Bye.\n\n");
}