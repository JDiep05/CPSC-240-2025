// *******************************************************************************************************************************
//  Program name: "Huron's Triangle". This program takes user input's of sides to create a triangle and output the area of the triangle.
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
// Program name: Huron's Triangle
// Programming languages: One module in C, Four module in X86, and One module in bash.
// Date program began: 2024-Mar-03
// Date of last update: 2024-Mar-08
// Files in this program: triangle.c, huron.asm, isfloat.asm, istriangle.asm, manager.asm, triangle.inc, r.sh
// Testing: Alpha testing completed.  All functions are correct.
// Status: Ready for release to the customers

// Purpose of this program:
//   This program takes three number inputs as sides to create a valid triangle
//   The program will calculate the area of the triangle
// This file:
//  File name: triangle.c
//  Language: C language
//  Max page width: 124 columns
//  Compile: gcc -c -m64 -Wall -no-pie -o triangle.o triangle.c -std=c2x
//  Link: gcc -m64 -no-pie -o triangle.out triangle.o manager.o isfloat.o istriangle.o huron.o
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**



#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern double manager();

int main(void) {
    char name[50];  // Allows name to hold 50 characters

    printf("\nWelcome to Huron's Triangles. We take care of all your triangle needs.\n");
    printf("\nPlease enter your name: ");
    fgets(name, sizeof(name), stdin);   // Ask for username with input
    if (name[strlen(name) -1] == '\n')  // If statement to remove newline from fget
        name[strlen(name) - 1] = '\0';
    double count = 0;
    count = manager();

    printf("\nThe main function has recieved this number %.4lf, and will keep it for a while.\n", count);
    printf("\nThank you %s. Your patronage is appreciated.\n", name);
    printf("\nA zero will now be return to the operating system\n");

}