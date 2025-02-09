// *******************************************************************************************************************************
//  Program name: "Triangle". This program calculates the third side of a triangle with two sides and an angle of a triangle based on user input
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
// Program name: Triangles
// Programming languages: One module in C, one in X86, and one in bash.
// Date program began: 2024-Feb-06
// Date of last update: 2024-Feb-08
// Files in this program: geometry.c, calculate_triangle.asm, run.sh.
// Testing: Alpha testing completed.  All functions are correct.
// Status: Ready for release to the customers

// Purpose of this program:
//  This program calculates for the third side of a triangle based on the user's input for the other two sides and the angle between them
// This file:
//  File name: geometry.c
//  Language: C language
//  Max page width: 124 columns
//  Compile: gcc -m64 -Wall -no-pie -o geometry.o -std=c2x -c geometry.c
//  Link: gcc -m64 -no-pie -o triangle.out calculate_triangle.o geometry.o -std=c2x -Wall -z noexecstack -lm
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

extern double calculate_triangle();   // Declare the external function "calculate_triangle" that returns a double.

int main(void) {
    printf("\nWelcome to the Triangle program maintained by Jonathan Diep.\n");
    printf("\nIf errors are discovered please report them to Jonathan Diep at jonathon.dieppp@csu.fullerton.edu for a quick fix.\n");
    printf("\nAt Fullerton Software the customer are prioritized.\n");
    double count = 0;   // Variable to hold the result of the third side
    count = calculate_triangle();   // Replacing "count" with the value of the third side
    printf("\nThe main function recieved this number %.9f and plans to keep it until needed.\n",count);   // Round "count" into 9 decimal places and display in a formatted text.
    printf("\nAn integer zero will be returned to the operating system. Goodbye!\n\n");
    return 0;
}